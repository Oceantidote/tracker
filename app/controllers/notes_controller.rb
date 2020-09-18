class NotesController < ApplicationController
  def new
  end

  def create
    @note = Note.new(note_params)
    @note.noteable = params[:note][:noteable_type].constantize.find(params[:note][:noteable])
    @note.user = current_user
    authorize @note
    if @note.save
      redirect_to polymorphic_path(@note.noteable)
    else
      raise
    end
  end

  def destroy
  end

  private

  def note_params
    params.require(:note).permit(:content)
  end
end
