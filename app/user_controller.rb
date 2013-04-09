class UserController < UIViewController
  def self.controller
    @controller ||= UserController.alloc.initWithNibName(nil, bundle: nil)
  end

  def viewDidLoad
    super
    self.view.backgroundColor = UIColor.whiteColor
    @status_label = UILabel.alloc.initWithFrame(CGRectZero)
    self.view.addSubview(@status_label)
  end

  def show_status(status)
    @status_label.text = status
    @status_label.sizeToFit
    @status_label.center = [@status_label.center.x, @status_label.center.y + @status_label.bounds.size.height]
  end
end