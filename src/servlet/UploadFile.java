package servlet;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URLEncoder;
import java.util.Iterator;
import java.util.LinkedHashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import db.DBExecute;
import tool.Format;
import tool.UUCode;

@WebServlet("/UploadFile")
public class UploadFile extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private static final String UPLOAD_DIR = "upload";

	//上传配置
	private static final int MEMORY_THRESHOLD = 1024 * 1024 * 3; //3MB
	private static final int MAX_FILE_SIZE = 1024 * 1024 * 20; //20MB
	private static final int MAX_REQUEST_SIZE = 1024 * 1024 * 30; //30MB
	
    public UploadFile() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		//配置上传属性
		DiskFileItemFactory factory = new DiskFileItemFactory();
		//设置内存临界值——超过后将产生临时文件并保存在临时目录中
		factory.setSizeThreshold(MEMORY_THRESHOLD);
		//设置临时存储目录
		factory.setRepository(new File(System.getProperty("java.io.tmpdir")));
		
		ServletFileUpload upload = new ServletFileUpload(factory);
		//设置文件上传最大值
		upload.setFileSizeMax(MAX_FILE_SIZE);
		//设置最大请求值（文件+表单数据）
		upload.setSizeMax(MAX_REQUEST_SIZE);
		//中文处理
		upload.setHeaderEncoding("UTF-8");
		
		String uploadPath = getServletContext().getRealPath("./") + UPLOAD_DIR;
		String type = request.getParameter("type");
		try {
			LinkedHashMap<String, String> info = new LinkedHashMap<String, String>();
			Iterator<FileItem> iter = upload.parseRequest(request).iterator();
			String tag = request.getParameter("tag");
			boolean hasTag = false;
			if(tag != null) {
				info.put("tag", tag);
				hasTag = true;
			}
			String code = UUCode.generateCode();
			while(iter.hasNext()) {
				FileItem item = iter.next();
				if(item.isFormField()) {
					String fieldKey = item.getFieldName();
					String fieldValue = item.getString("UTF-8");
					if(fieldKey.equals("price") && !Format.allDigit(fieldValue)) {
						response.sendRedirect(request.getParameter("nowPath") + "?fail=true");
						return;
					}
					info.put(fieldKey, fieldValue);
				}
				else {
					File uploadDir = new File(uploadPath);
					if(!uploadDir.exists()) {
						uploadDir.mkdir();
					}
					//如果没有上传文件则跳过
					String fileName = item.getName();
					if(fileName == null || fileName.trim().equals("")) {
						continue;
					}
					String filePath = uploadPath + File.separator + code + ".jpg";
					File storeFile = new File(filePath);
					item.write(storeFile);
					/*
					InputStream inputStream = item.getInputStream();
					FileOutputStream outputStream = new FileOutputStream(filePath);
					byte buffer[] = new byte[1024];
					int len = 0;
					while((len=inputStream.read(buffer)) > 0) {
						outputStream.write(buffer, 0, len);
					}
					inputStream.close();
					outputStream.close();
					*/
				}
			}
			if(!type.equals("vipLevel")) {
				info.put("code", code);				
			}
			DBExecute.insert(info, type);
			String nextPath = request.getParameter("nextPath");
			if(hasTag) {
				response.sendRedirect(nextPath + "?tag=" + URLEncoder.encode(tag, "UTF-8"));				
			}
			else {
				response.sendRedirect(nextPath);
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
