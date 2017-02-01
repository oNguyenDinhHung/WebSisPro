class DangkihocphansController < ApplicationController
	include ApplicationHelper
	before_action :logged_in_user
	before_action :chinh_chu , only: [:show]
	before_action :set_x, only: [:destroy]
	before_action :not_permit ,only: [:new,:create]
	def index		
	end	
	def new
		@dangkihocphan = Dangkihocphan.new
	end
	def show
		@sinhvien=Sinhvien.find_by_id(params[:id])
		unless @sinhvien && @sinhvien==@current_sinhvien
			flash[:info]="Không phải chính chủ"
			redirect_to root_url
		else		
			if mo_dangki_hocphan?				
				if params[:khoavien_id]&&params[:khoavien_id]!=""
					@hocphans=@hocki_modangkihocphan.hocphans.joins(:khoavien)
					.where("khoavien_id = ? and tenhocphan like ? and mahocphan like ?",params[:khoavien_id],"%#{params[:tenhocphan]}%","%#{params[:mahocphan]}%")
					.reorder(:mahocphan)
					.select("hocphans.*","tenkhoavien")
					.distinct.paginate(page: params[:page],:per_page=>20)
				else
					@hocphans=@hocki_modangkihocphan.hocphans.joins(:khoavien)
					.where("tenhocphan like ? and mahocphan like ?","%#{params[:tenhocphan]}%","%#{params[:mahocphan]}%")
					.reorder(:mahocphan)
					.select("hocphans.*","tenkhoavien")
					.distinct.paginate(page: params[:page],:per_page=>20)
				end					
				@registeds=@sinhvien.hocphans
					.where("hocki_id=?",@hocki_modangkihocphan.id)
					.select("hocphans.*","dangkihocphans.id as dkhp_id")
			else
				flash[:info]="Không có học kì nào mở đăng kí"
				redirect_to root_url
			end
		end				
	end
	def edit		
	end
	def destroy
		@dangkihocphan.destroy
		flash[:info]= 'Đã xóa .'
		redirect_back fallback_location: root_path
	end
	def update
  	end
	def create
		@dangkihocphan=Dangkihocphan.new(x_params)
		if @dangkihocphan.save
			flash[:success]= 'Tạo mới thành công.'					        
		else			
		    flash[:danger]= 'Tạo mới thất bại: '+@dangkihocphan.errors.full_messages.join(',')
		end
		redirect_back fallback_location: root_path		
    end	
	private
	def set_x
		unless @dangkihocphan=Dangkihocphan.find_by_id(params[:id])		
			flash[:info]="Không tìm thấy dữ liệu ."
			redirect_to root_url
		end	
	end
	def x_params
	    params.require(:dangkihocphan).permit(:sinhvien_id,:hocphan_id,:hocki_id)
	end	
	def chinh_chu
    	if sinhvien? && params[:dangkihocphan]  
        unless @current_sinhvien.id==params[:dangkihocphan][:sinhvien_id].to_i
          flash[:danger]="Bạn không phải chính chủ !"
          redirect_to(root_url) 
        end
        end
    end
    def not_permit
    	unless @hocki_modangkihocphan=Hocki.find_by_modangkihocphan(true)
    		flash[:danger]="Hiện không có học kì nào mở đăng kí học phần"
    		redirect_to root_url 
    	end
    end
end
