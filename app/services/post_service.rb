# app/services/post_service.rb
class PostService

  def initialize(**kwargs)
    @kwargs = kwargs
    @errors = []
  end

  def self.call(**kwargs)
    new(**kwargs).call
  end

  def call
    run
  end

  private

  def run
    user = User.find_or_initialize_by(login: @kwargs[:user_params][:login])
    post = user.posts.build(@kwargs[:post_params])

    unless user.save && post.save
      @erros += user.errors.full_messages
      @erros += post.errors.full_messages
    end
  end
end
