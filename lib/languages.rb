require 'cldr/languages/version'
require 'cldr'
require 'yaml'
require 'fileutils'

module Cldr
  module Languages

    DEFAULT_LANGUAGE_CODE = 'en'
    DEFAULT_SELF_LOCALIZATION_CODE = 'zxx'

    def import(opts = {})
      language_codes = language_codes(true)

      root_folder = opts[:root_folder] ? opts[:root_folder] : '';

      if !File.directory?(root_folder + 'config')
        FileUtils.mkdir_p(root_folder + 'config')
        FileUtils.mkdir_p(root_folder + 'config/locales')
      elsif !File.directory?(root_folder + 'config/locales')
        FileUtils.mkdir_p(root_folder + 'config/locales')
      end

      language_codes.each do |languageCode|
        localized_languages = localized_languages(language: languageCode)
        localized_languages_content = Hash.new
        localized_languages_content[languageCode] = localized_languages
        yaml_content = localized_languages_content.to_yaml

        File.open(root_folder + "config/locales/languages.#{languageCode}.yml", 'w') do |f|
          f.write(yaml_content)
        end
      end
    end

    def language_codes(self_localization = false)
      default_language = language(DEFAULT_LANGUAGE_CODE)
      default_language_object = CLDR::Object.new(locale: default_language)

      language_codes = default_language_object.core.languages.keys

      if self_localization
        language_codes
      else
        language_codes.reject! { |k| k == DEFAULT_SELF_LOCALIZATION_CODE }
      end
    end

    def localized_languages(opts = {})
      localization_language = language(opts[:language])
      fallback_language = language(opts[:fallback])

      if opts[:language] && opts[:language].to_s == DEFAULT_SELF_LOCALIZATION_CODE
        all_language_codes = language_codes

        Hash[all_language_codes.map { |languageCode|
          language_from_code = Locale::Tag::Cldr.new(languageCode)
          localized_language_object = CLDR::Object.new(locale: language_from_code, fallback: fallback_language)

          [languageCode, localized_language_object.core.languages[languageCode]]
        }]
      else
        localization_language_object = CLDR::Object.new(locale: localization_language, fallback: fallback_language)
        localization_language_object.core.languages
      end
    end

    private

    def language(language_string)
      default_language_string = language_string ? language_string : DEFAULT_LANGUAGE_CODE
      Locale::Tag::Cldr.new(default_language_string)
    end

  end

end
