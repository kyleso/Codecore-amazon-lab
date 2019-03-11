class ProductMailer < ApplicationMailer
  def notify_product_creator(product)
    @product = product
    @product_owner = @product&.user

    mail(
      to: @product_owner&.email,
      from: "no-reply@awesome-answers.io",
      subject: "#{@product&.user.full_name}, your product #{@product&.title} has been created!",
    )
  end
end
