require 'cldr/languages/version'
require 'cldr'
require 'yaml'
require 'fileutils'

module Cldr
  module Languages

    DEFAULT_LANGUAGE_CODE = 'en'
    DEFAULT_SELF_LOCALIZATION_CODE = 'zxx'

    def import
      languageCodes = language_codes(true)

      if !File.directory?('config')
        FileUtils.mkdir_p('config')
        FileUtils.mkdir_p('config/locales')
      elsif !File.directory?('config/locales')
        FileUtils.mkdir_p('config/locales')
      end

      languageCodes.each do |languageCode|
        localizedLanguages = localized_languages(language: languageCode)
        localizedLanguagesContent = Hash.new
        localizedLanguagesContent[languageCode] = localizedLanguages
        yamlContent = localizedLanguagesContent.to_yaml

        File.open("config/locales/languages.#{languageCode}.yml", 'w') do |f|
          f.write(yamlContent)
        end
      end
    end

    def language_codes(includeSelfLocalization = false)
      defaultLanguage = language(DEFAULT_LANGUAGE_CODE)
      defaultLanguageObject = CLDR::Object.new(locale: defaultLanguage)

      languageCodes = defaultLanguageObject.core.languages.keys

      if includeSelfLocalization then
        return languageCodes
      else
        return languageCodes.reject! { |k| k == DEFAULT_SELF_LOCALIZATION_CODE }
      end
    end

    def localized_languages(opts = {})
      localizationLanguage = language(opts[:language])
      fallbackLanguage = language(opts[:fallback])

      if opts[:language] && opts[:language].to_s == DEFAULT_SELF_LOCALIZATION_CODE then
        languageCodes = language_codes

        return Hash[languageCodes.map { |languageCode|
          languageFromCode = Locale::Tag::Cldr.new(languageCode)
          localizedLanguageObject = CLDR::Object.new(locale: languageFromCode, fallback: fallbackLanguage)

          [languageCode, localizedLanguageObject.core.languages[languageCode]]
        }]
      else
        localizationLanguageObject = CLDR::Object.new(locale: localizationLanguage, fallback: fallbackLanguage)
        return localizationLanguageObject.core.languages
      end
    end

    private

    def language(languageString)
      defaultLanguageString = languageString ? languageString : DEFAULT_LANGUAGE_CODE
      return Locale::Tag::Cldr.new(defaultLanguageString)
    end

  end

end
