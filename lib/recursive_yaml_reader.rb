
#
# Reads yaml files such that settings in child dirs are
# merged into settings from parent dirs.
# Usage:
# RecursiveYamlReader.new.read_settings(
#   :root_dir => '/foo',
#   :target_dir => '/foo/bar/baz',
#   :file_name => 'metadata.yml',
#   :defaults => {'foo' => 'bar'} # (optional)
# )
#
class RecursiveYamlReader
  def read_settings(options)
    @opts = options
    require_option(:root_dir)
    require_option(:target_dir)
    require_option(:file_name)
    
    raise ':target_dir must start with :root_dir' unless @opts[:target_dir].start_with?(@opts[:root_dir])
    
    root_dir = @opts[:root_dir]
    target_dir = @opts[:target_dir]
    file_name = @opts[:file_name]
    
    subdirs = @opts[:target_dir].gsub(/^#{@opts[:root_dir]}\//, '').split("/")

    @result = @opts[:defaults] || {}
    merge_file("#{root_dir}/#{file_name}")
    subdirs.each_index do |i|
      merge_file("#{root_dir}/#{subdirs[0..i].join('/')}/#{file_name}")
    end
    
    @result
  end
  
private
  def require_option(name)
    raise "option :#{name} is required" if @opts[name].nil?
  end
  
  def merge_file(path)
    if FileTest.exists? path
      @result = @result.merge(YAML.load_file(path))
    end
  end
end
