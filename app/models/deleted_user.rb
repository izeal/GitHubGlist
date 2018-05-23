class DeletedUser

  def name
    "Deleted"
  end

  def decorate
    self
  end

  def avatar
    ActionController::Base.helpers.asset_path('deleted.jpg')
  end

  def null_object?
    true
  end
end
