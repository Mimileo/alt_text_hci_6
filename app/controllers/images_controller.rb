 class ImagesController < ApplicationController

    def new 
        image_dup_check
    end 

    def create
       
    end

    def destroy
        @image.destroy
    end

     def image_dup_check
        puts "check"
     end

    private

    def image_params
        params.permit(:image)
    end
    
 end
