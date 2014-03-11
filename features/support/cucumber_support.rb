def verify_feature(feature)
  @features = compute_features unless defined?(@features) and @features
  @features.should include(feature), %Q/requires feature "#{feature}"/
end

def compute_features
  set = features_in_directory('features')
  set.collect! { |name| CucumberHelper.feature_name(name) }
end

def features_in_directory directory
  set = Set.new
  dir = Dir.new(directory)

  dir.each() do |name|
    next if name =~ /^\./
    pn = "#{directory}/#{name}"

    if File.directory?(pn)
      set.merge(features_in_directory(pn))
      next
    end

    if name=~/^(.*)\.feature$/
      set.add($1)
    end
  end

  set
end
