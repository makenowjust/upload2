# frozen_string_literal: true

class FilesController < ApplicationController
  include FileInfoConcern

  def index
    @file_infos = FileInfo.public_file_infos
    @file_info = FileInfo.new
  end

  def show; end

  def create
    @file_info = FileInfo.new(file_info_params)

    if @file_info.save
      redirect_to @file_info, notice: 'Uploading OK'
    else
      render status: :bad_request
    end
  end

  def destroy
    password = params[:password]

    if @file_info.authenticate(password)
      @file_info.destroy!
      redirect_to({ action: :index }, notice: 'Deleting OK')
    else
      redirect_to @file_info, alert: 'Deleting Failed (Invalid Password)'
    end
  end

  private def file_info_params
    params.require(:file_info).permit(
      :file,
      :private,
      :expiration,
      :password,
      :password_confirmation
    )
  end
end
