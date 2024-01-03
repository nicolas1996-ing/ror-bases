# patron aplicado: query object pattern 
class FindProducts 
    attr_reader :products

    # constructor
    # si no le enviamos argumentos a la instancia se llama el metodo initial_scope
    def initialize(products = initial_scope)
        @products = products
    end

    # metodos de instancia
    # params solo existe en el contexto del método call
    def call(params = {}) 
        scoped = @products
        scoped = filter_by_category_id(scoped, params[:category_id])
        scoped = filter_by_min_price(scoped, params[:min_price])
        scoped = filter_by_max_price(scoped, params[:max_price])
        scoped = filter_by_query_text(scoped, params[:search])
        sort(scoped, params[:order_by])
    end

    private 
    def initial_scope
        Product.with_attached_photo
    end

    def filter_by_category_id(scoped, category_id)
        return scoped if category_id.blank?
        scoped.where(category_id: category_id)
    end

    def filter_by_min_price(scoped, min_price)
        return scoped if min_price.blank?
        scoped.where("price >= ?", min_price.to_i)
    end

    def filter_by_max_price(scoped, max_price)
        return scoped if max_price.blank?
        scoped.where("price <= ?", max_price.to_i)
    end

    def filter_by_query_text(scoped, query_text)
        return scoped if query_text.blank?
        scoped.where("title like ?", "%#{query_text}%")
    end

    def sort(scoped, order_by)
        scoped.order(Product::ORDER_BY.fetch(order_by&.to_sym, "created_at DESC"))
    end
end

# ejemplo de uso: FindProducts.new.call({min_price: 400, max_price: 500})