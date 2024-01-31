require "open-uri"
# in order to take the html
class Metadata
    attr_reader :doc

    def self.retrieve_from(url)
        new(URI.open(url))
    rescue StandardError
        new
    end

    def initialize(html=nil)
        @doc = Nokogiri::HTML(html)
    end

    def attributes
        {
            title: title,
            description: description,
            image: image
        }
    end

    def title
        doc.at_css("title")&.text
    end

    def description
        # doc.at_css("meta[name='description']")&.attributes&.fetch("content", nil)&.text
        meta_tag_content "description"
    end

    def image
        # doc.at_css("meta[name='og:image']")&.attributes&.fetch("content", nil)&.text
        meta_tag_content "og:image", name_attribute: :property
    end

    def meta_tag_content(name, name_attribute: :name)
        doc.at_css("meta[#{name_attribute}='#{name}']")&.attributes&.fetch("content", nil)&.text
    end
end
