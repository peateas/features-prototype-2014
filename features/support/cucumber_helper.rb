require 'Cucumber'

class CucumberHelper
  attr_reader :features, :matched, :unmatched, :extra

  def initialize(directory, logger)
    config = Cucumber::Cli::Configuration.new
    config.parse!([directory])
    loader = Cucumber::Runtime::FeaturesLoader.new(
        config.feature_files,
        config.filters,
        config.tag_expression)
    @features=loader.features
    @logger=logger
  end

  def verify_names
    @matched = []
    @unmatched = []
    @features.each do |feature|
      name = feature.title
      target = File.basename(feature.location.file)
      expected = CucumberHelper.filename(name)
      if target == expected
        matched << feature
      else
        @logger.warn("mismatched feature #{name}:  expected #{expected}: got #{target}")
        unmatched << feature
      end
    end
  end

  def check_for_extra_features
    @logger.warn("check for extra features not implemented always return empty array")
    @extra = []
  end

  def self.feature_name filename
    filename.gsub(/.feature$/, '').gsub(/_/, ' ').capitalize
  end

  def self.filename feature_name
    feature_name.gsub(/ /, '_').downcase+'.feature'
  end

end


