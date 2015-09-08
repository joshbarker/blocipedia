class CollaboratorsController < ApplicationController 

  def new
    @collaborator = Collaborator.new
    @users = User.all
  end

  def create
    @wiki = Wiki.find(params[:wiki_id])
    @collaborator = Collaborator.new(wiki_id: @wiki.id, user_id: params[:user_id])

    if @collaborator.save
      flash[:notice] = "Collaborator was added."
      redirect_to edit_wiki_path(@wiki)
    else
      flash[:error] = "There was an error updating your wiki. Please try again."
      render :new
    end
  end

  def destroy
    @wiki = Wiki.find(params[:wiki_id])
    #@collaborator = Collaborator.find(params[:id])
    @collaborator = Collaborator.find(params[:id])


    if @collaborator.destroy
      flash[:notice] = "Collaborator was deleted"
      redirect_to edit_wiki_path(@wiki)
    else
      flash[:error] = "There was an error. Please try again."
      render :show
    end
  end


private

  def wiki_params
    @wiki = Wiki.find(params[:wiki_id])
  end

  def collaborator_params
    params.require(:collaborators).permit(:wiki_id, :user_id)
  end

end