class DownloadController < ApplicationController
  include FileInfoConcern

  def show
    @file_content = @file_info.file_content
    send_data @file_content.content, filename: @file_info.name, disposition: :inline
  end
end
