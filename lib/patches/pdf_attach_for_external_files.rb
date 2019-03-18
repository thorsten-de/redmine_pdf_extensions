module PdfExtensions
  module Patches::PdfAttachForExternalFiles
    def attach(attachments, filename, encoding)
      # Let Redmine do the work first. If it finds an attachment, we're all done.
      attachment = super(attachments, filename, encoding)
      return attachment if attachment

      # There was no corresponding attachment in our object (issue). We'll look for it in all attachments...
      # is our filename a route to an attachment? Extract the id as first pattern match group
      /attachments\/download\/(\d+)\/.*\.(gif|jpeg|jpg|png)\z/.match(filename) do |match|
        # Load attachment with the matched id from databse
        # Hint: match[0] is the whole match, match[1] is the first group, our id
        attachment = Attachment.find(match[1])

        if attachment && attachment.readable? && attachment.visible?
          return attachment
        else
          return nil
        end
      end

      # No attachment found, so return nil. The image file won't be loaded, just the filename is rendered into the pdf
      nil
    end
  end
end