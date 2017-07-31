require 'patches/pdf_attach_for_external_files'
module PdfExtensions
  def self.apply_patches()
    Redmine::Export::PDF::RDMPdfEncoding.singleton_class.prepend Patches::PdfAttachForExternalFiles
  end
end
