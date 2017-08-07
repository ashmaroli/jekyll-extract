# frozen_string_literal: true

module Jekyll
  class ThemeGemExtractor
    attr_reader :site, :options, :theme_root

    def initialize(site, options)
      @site = site
      @options = options
      @theme_root = site.in_theme_dir("/")
    end

    def extract(path)
      file_path = site.in_theme_dir path
      unless File.exist?(file_path)
        puts ""
        raise ArgumentError,
          "Specified path #{path.yellow} doesn't exist in the theme-gem."
      end
      extract_to_source file_path
    end

    def extract_to_source(path)
      return list_contents(path) if options["show"]

      if File.directory? path
        extract_directory_contents path
      else
        extract_file_with_directory path
      end
    end

    def extract_directory_contents(path)
      destination = site.in_source_dir relative_path(path)
      if File.exist?(destination) && !options["force"]
        already_exists_msg path
      else
        extract_contents path, destination
      end
    end

    def extract_contents(source, destination)
      FileUtils.cp_r "#{source}/.", destination
      files_in(source).each do |file|
        extraction_msg file
      end
    rescue Errno::ENOENT
      FileUtils.mkdir_p destination
      retry
    end

    def extract_file_with_directory(file_path)
      file = file_path.split("/").last
      dir_path = File.dirname(
        site.in_source_dir(relative_path(file_path))
      )
      FileUtils.mkdir_p dir_path

      if File.exist?(File.join(dir_path, file)) && !options["force"]
        already_exists_msg file_path
      else
        FileUtils.cp_r file_path, dir_path
        extraction_msg file_path
      end
    end

    def list_contents(path)
      if File.directory? path
        directory_listing path
      else
        Jekyll.logger.warn "", "The --show switch only works for directories"
      end
    end

    def directory_listing(path)
      Jekyll.logger.info "Listing:",
        "Contents of '#{relative_path(path)}' in theme gem..."

      files_in(path).each do |file|
        Jekyll.logger.info "", "  * #{relative_path(file)}"
      end
    end

    def files_in(dir_path)
      Dir["#{dir_path}/**/*"].reject { |d| File.directory? d }
    end

    def relative_path(path)
      path.sub theme_root, ""
    end

    def extraction_msg(file)
      Jekyll.logger.info "Extract:", relative_path(file)
    end

    def already_exists_msg(file)
      Jekyll.logger.warn "Error:", "'#{relative_path(file)}' already " \
        "exists at destination. Use --force to overwrite."
    end
  end
end
