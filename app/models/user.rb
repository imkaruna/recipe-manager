class User < ActiveRecord::Base
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :omniauthable, :omniauth_providers => [:facebook]

    devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

    has_many :comments


    def self.from_omniauth(auth)
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.email = auth.info.email
        user.password = Devise.friendly_token[0,20]
        user.first_name = auth.info.name   # assuming the user model has a name
        # user.image = auth.info.image # assuming the user model has an image
      end
    end
end
