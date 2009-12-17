require 'erb'
require 'useful/ruby_extensions/string'

module SinatraHelpers; end

module SinatraHelpers::Generator

  class App
    
    attr_reader :root_path, :name
    
    def initialize(path)
      @root_path = File.dirname(path)
      self.name = File.basename(path)
      @class_name = @name.classify
    end
    
    def name=(name)
      @name = name.gsub(/([A-Z])([a-z])/, '-\1\2').sub(/^-/, '').downcase
    end
    
    def generate
      build_template(File.join(self.root_path, self.name), SinatraHelpers::Generator::TEMPLATE)
    end
    
    private
    
    def build_template(root_path, dir_hash)
      FileUtils.mkdir_p(root_path)
      dir_hash.each do |k, v|
        if v.kind_of?(::Hash)
          build_template(File.join(root_path,k.to_s), v)
        elsif v.kind_of?(::String)
          build_template_file(root_path, k.to_s, v.to_s)
        end
      end
    end
    
    def build_template_file(root_path, erb_name, file_name)
      source_file = File.join(File.dirname(__FILE__), "file_templates", erb_name)
      output_file = File.join(root_path, file_name)

      unless File.exists?(output_file)      
        if ['.erb'].include?(File.extname(source_file))
          erb = ERB.new(File.read(source_file))
          File.open(output_file, 'w') {|f| f << erb.result(binding) }
        else
          FileUtils.cp(source_file, output_file)
        end
      end
    end

  end

end
