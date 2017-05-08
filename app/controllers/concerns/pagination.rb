module Pagination
  extend ActiveSupport::Concern

  included do
    after_action :paginate_headers
  end

  private

  def paginate(collection)
    unless collection.kind_of?(Array)
      @paginated_collection = collection.page(params[:page]).per(10)
    else
      @paginated_collection = Kaminari.paginate_array(collection).page(params[:page]).per(10)
    end
    @paginated_collection
  end

  def paginate_headers
    return unless @paginated_collection
    headers['X-Total-Count'] = @paginated_collection.total_count
    headers['X-Page'] = @paginated_collection.current_page
    headers['X-Per-Page'] = @paginated_collection.default_per_page
  end
end