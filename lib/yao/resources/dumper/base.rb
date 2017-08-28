module Yao::Resources::Dumper
  class Base

    def self.fields=(v)
      @fields = v
    end

    def initialize
      @bug_fields = []
    end

    def self.bug_fields=(v)
      @bug_fields = v
    end

    def self.dump(obj)
      [obj].flatten.map do |o|
        arr = @fields.map{|field|
          # bugfixされるまで特定のメソッドは `_id` をつける
          if @bug_fields.include?(field)
            name = field + "_id"
            [name, o.send("[]", name)]
          else
            result = o.send(field)

            result = if result.instance_of?(Array)
                      result.map{|r| resource_dump(r)}
                    else
                      resource_dump(result)
                    end

            [field, result]
          end
        }.flatten(1)

        Hash[*arr]
      end
    end

    private
    def self.resource_dump(obj)
      result = obj
      if m = obj.class.to_s.match(/^Yao::Resources::(.+)$/)
        if obj.id.nil?
          # とりあえずnameを返しておく(Yao::Resources::SecurityGroup)
          result = {"name": obj.name}
        else
          # Yao::ResourcesにマッピングされているがIDのみなので
          # getして情報を取得する
          resource = obj.class.get(obj.id)
          result = Object.const_get("Yao::Resources::Dumper::#{m[1]}").dump(resource)
        end
      end
      if result.instance_of?(Array)
        result.size == 1 ? result.first : result
      else
        result
      end
    end
  end
end
