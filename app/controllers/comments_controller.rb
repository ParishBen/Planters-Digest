class CommentsController < ApplicationController
   include UsersHelper

    def index 
        redirect_if_not_logged_in
        if params[:plant_id]
            @plant = Plant.find_by(id: params[:plant_id])
            @comments = @plant.comments
            @comment = Comment.new
        else 
            @comments = Comment.all 
      end
    end

    def new
        redirect_if_not_logged_in
        @comment = Comment.new
        if params[:plant_id]
             @plant = Plant.find_by(id: params[:plant_id])
             @comment = @plant.comments.build
        end
    end

    def create
        redirect_if_not_logged_in
        @comment = Comment.new(comment_params)
        @plant = Plant.find_by(id: @comment.plant_id)
        @comment.commenter_id = current_user.id
        if @comment.save
            redirect_to plant_path(@plant)
        else
            flash[:notice]= "Please ensure content is not empty."
            render :new
        end
    end

    def edit
        redirect_if_not_logged_in
        @comment = Comment.find(params[:id])
        not_the_commenter
    end

    def update
        redirect_if_not_logged_in
        @comment = Comment.find(params[:id])
        not_the_commenter
        @comment.update(comment_params)
        if @comment.save
            redirect_to plant_path(@comment.plant)
        else 
            flash[:notice]= "Please ensure content is not empty." 
            render :edit
        end
    end

    def show
        redirect_if_not_logged_in
        @comment = Comment.find(params[:id])
        flash[:message]= "Directed To Comment's Plant Page"
        redirect_to plant_path(@comment.plant)
        end

    def destroy
        redirect_if_not_logged_in
        @comment = Comment.find(params[:id])
        not_the_commenter
        if @comment.destroy
            redirect_to plant_path(@comment.plant)
        end
    end

 private

    def comment_params
        params.require(:comment).permit(:plant_id, :commenter_id, :content)
    end


end
