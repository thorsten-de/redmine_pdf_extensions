require 'patches/pdf_attach_for_external_files'
require 'patches/pdf_qr_code_for_issue'
module PdfExtensions
  def self.apply_patches()
    Redmine::Export::PDF::RDMPdfEncoding.singleton_class.prepend Patches::PdfAttachForExternalFiles
    IssuesHelper.include Patches::PdfQrCodeForIssue
  end
end
