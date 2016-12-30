module ViewNamespaceHelper
  def view_namespace_path
    path, _ = controller_path.rpartition('/')
    path
  end
end
