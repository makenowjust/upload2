class DownloadController < ApplicationController
  before_action :set_file_info, only: %i(show)

  def show
    @file_content = @file_info.file_content
    send_data @file_content.content, filename: @file_info.name, disposition: :inline
  end

  private def set_file_info
    @file_info = FileInfo.find_by_hashid!(params[:id])
    raise ActiveRecord::RecordNotFound.new("#{params[:id]} is outdated") if @file_info.outdated?
  end
end
