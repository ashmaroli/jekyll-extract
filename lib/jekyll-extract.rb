# frozen_string_literal: true

module Jekyll
  autoload :ThemeGemExtractor, "theme_gem_extractor"

  module Commands
    class Extract < Command
      class << self
        def init_with_program(prog)
          prog.command(:extract) do |c|
            c.syntax "extract [DIR (or) FILE-PATH] [options]"
            c.description "Extract theme-gem contents to source directory"

            c.option "show", "--show", "List the contents of the specified [DIR]"
            c.option "force", "--force", "Force extraction even if file already exists"
            c.option "list-all", "--list-all", "List all files in the theme-gem"

            c.action do |args, options|
              process(args, options)
            end
          end
        end

        def process(args, options = {})
          unless options["list-all"]
            raise ArgumentError, "You must specify a path." if args.empty?
          end

          config = Jekyll.configuration(options)
          @site ||= Site.new(config)

          Jekyll.logger.info "Source Directory:", config["source"]
          Jekyll.logger.info "Theme Directory:", @site.theme.root
          puts ""

          return list_all_files if options["list-all"]

          # Substitute leading special-characters in an argument with an
          # 'underscore' to disable extraction of files outside the theme-gem
          # but allow extraction of theme directories with a leading underscore.
          #
          # Process each valid argument individually to enable extraction of
          # multiple files or directories.
          args.map { |i| i.sub(%r!\A\W!, "_") }.each do |arg|
            ThemeGemExtractor.new(@site, options).extract arg
          end
        end

        private

        def list_all_files
          Jekyll.logger.info "Listing:", "All files in current theme"
          Dir["#{@site.theme.root}/**/*"].each do |file|
            next if File.directory?(file)
            Jekyll.logger.info "",
              "  * #{file.sub(@site.in_theme_dir("/"), "")}"
          end
        end
      end
    end
  end
end
