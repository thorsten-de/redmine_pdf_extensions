module PdfExtensions
  module Patches::PdfDisplayExternalImages
    def get_image_filename(attrname)
      # Use Redmine logic to get a filename from an attachment
      possible_filename = super
      # and just return it, if it exists.
      return possible_filename if super

      # If no file exists (possible_filename is nil), 
      # return sanitized (external) url
      attrname_utf8 = Redmine::CodesetUtil.to_utf8(attrname, "UTF-8")
      if attrname_utf8 =~ /[^-_.!~*'()a-zA-Z\d;\/?:@&=+$,\[\]%]/n
        return URI.encode(attrname_utf8)
      else
        return attrname_utf8
      end 
    end
  end
end