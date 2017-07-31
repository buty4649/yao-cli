module Yao::Resources::Dumper
  class Base

    def self.fields=(v)
      @fields = v
    end

    def self.dump(obj)
      [obj].flatten.map do |o|
        arr = @fields.map{|field|
          result = o.send(field)

          result = if result.instance_of?(Array)
                    result.map{|r| resource_dump(r)}
                   else
                    resource_dump(result)
                   end

          [field, result]
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
      result
    end
  end
end