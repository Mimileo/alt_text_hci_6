class ImgDupMailer < ApplicationMailer

	default from: "Seven Army <kate@seven.army>"

	def send_image_dup_notification(alt, image, user)
	    @user = user
	    @alt = alt
	    @image = image
	    mail( to: @user.email, subject: '[seven.army] Image Verification Complete — Duplicate Image')
	end

	def send_image_not_dup_notification(alt, image, user)
	    @user = user
	    @alt = alt
	    @image = image
	    mail( to: @user.email, subject: '[seven.army] Image Verification Complete — Original Image')
	end

	def send_error(user)
	    @user = user
	    mail( to: @user.email, subject: '[seven.army] An Error Occurred')
	end
end
