class LoginController < Formotion::FormController
  def init
    form = Formotion::Form.new({
      title: "Login",
      sections: [{
        rows: [{
          title: "Email",
          type: :string,
          placeholder: "user@domain",
          key: :username
        }, {
          title: "Password",
          type: :string,
          placeholder: "password",
          key: :password,
          secure: true
        }]
      }, {
        rows: [{
          title: "Login",
          type: :submit,
        }]
      }]
    })
    form.on_submit do
      self.login
    end
    super.initWithForm(form)
  end

  def viewDidLoad
    super
    self.navigationItem.rightBarButtonItem = UIBarButtonItem.alloc.initWithTitle("Login", style: UIBarButtonItemStyleDone, target:self, action:'login')
  end

  def login
    BW::HTTP.post("http://192.168.0.35:3000/api/login", payload: {:username => form.render[:username], :password => form.render[:password]}) do |response|  
      begin
        result = BW::JSON.parse(response.body.to_str)
        UserController.controller.show_status("Welcome #{result[:username].to_str}" )
      rescue
        UserController.controller.show_status("login failed")
      end
    end
    self.navigationController.dismissModalViewControllerAnimated(true)
  end
end