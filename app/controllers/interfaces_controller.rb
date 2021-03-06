class InterfacesController < ApplicationController

    load_and_authorize_resource

	def index
        @interfaces = Interface.paginate(page: params[:page], per_page: params[:per_page])
        sort = %w(name uri version).include?(params[:sort]) ? params[:sort] : :name
        order = 'desc' == params[:order] ? :desc : :asc
        @interfaces = @interfaces.order(sort => order)
        @interfaces = @interfaces.search_by_name(params[:name]) if params[:name]
    end


    def show; end

    # POST /interfaces
    # POST /interfaces.json
    def create
        @interface = Interface.new(interface_params)

        respond_to do |format|
            if @interface.save
                format.html { redirect_to @interface, notice: 'Interface was successfully created.' }
                format.json { render :show, status: :created, location: @interface }
            else
                format.html { render :new }
                format.json { render json: @interface.errors, status: :unprocessable_entity }
            end
        end
    end

    # PATCH/PUT /interfaces/1
    # PATCH/PUT /interfaces/1.json
    def update
        respond_to do |format|
            if @interface.update(interface_params)
                format.html { redirect_to @interface, notice: 'Interface was successfully updated.' }
                format.json { render :show, status: :ok, location: @interface }
            else
                format.html { render :edit }
                format.json { render json: @interface.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /interfaces/1
    # DELETE /interfaces/1.json
    def destroy
        @interface.destroy
        respond_to do |format|
            format.html { redirect_to interfaces_url, notice: 'Interface was successfully destroyed.' }
            format.json { head :no_content }
        end
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_interface
        @interface = Interface.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def interface_params
        params.require(:interface).permit(:name, :uri, :version, :ordinal)
    end
end
