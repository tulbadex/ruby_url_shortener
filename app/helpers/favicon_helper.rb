module FaviconHelper
    def favicon_image_tag(domain, **kwargs)
        image_tag google_faivon_url(domain), **kwargs
    end

    def google_faivon_url(domain)
        "https://www.google.com/s2/favicons?domain=#{domain}"
    end
end