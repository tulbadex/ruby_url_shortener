class MetadataJob < ApplicationJob
    def perform(id)
        link = Link.find(id)
        link.update Metadata.retrieve_from(link.url).attributes
        # Metadata.update(link)
        link.broadcast_replace_to(link)
    end
  end
  