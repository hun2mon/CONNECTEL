package com.connec.tel.servlet;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.ServletException;

import java.io.IOException;
import java.util.List;

import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.connec.tel.dto.EmpDTO;
import com.connec.tel.service.EmpService;

@WebServlet("/excel/download")
public class ExcelDownloadServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private EmpService empService;

    @Override
    public void init() throws ServletException {
        super.init();
        WebApplicationContext context = WebApplicationContextUtils.getRequiredWebApplicationContext(getServletContext());
        empService = context.getBean(EmpService.class);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<EmpDTO> employees = empService.excelList();
        
        Workbook workbook = new XSSFWorkbook();
        Sheet sheet = workbook.createSheet("Employees");

        int rowIdx = 0;
        Row headerRow = sheet.createRow(rowIdx++);
        headerRow.createCell(0).setCellValue("사원번호");
        headerRow.createCell(1).setCellValue("이름");
        headerRow.createCell(2).setCellValue("부서");
        headerRow.createCell(3).setCellValue("직급");
        headerRow.createCell(4).setCellValue("이메일");
        headerRow.createCell(5).setCellValue("생년월일");
        headerRow.createCell(6).setCellValue("연락처");
        headerRow.createCell(7).setCellValue("주소");
        headerRow.createCell(8).setCellValue("재직상태");

        for (EmpDTO emp : employees) {
            Row row = sheet.createRow(rowIdx++);
    	    int rank_code = emp.getRank_code();
    	    String rank = getRankDescription(rank_code);


    	    // 부서 코드 변환
    	    int dept_code = emp.getDept_code();
    	    String dept = getDeptDescription(dept_code);
    	    
    	    
            row.createCell(0).setCellValue(emp.getEmp_no());
            row.createCell(1).setCellValue(emp.getName());
            row.createCell(2).setCellValue(dept);
            row.createCell(3).setCellValue(rank);
            row.createCell(4).setCellValue(emp.getEmail());
            row.createCell(5).setCellValue(emp.getBirth());
            row.createCell(6).setCellValue(emp.getPhone());
            row.createCell(7).setCellValue(emp.getAddress());
            row.createCell(8).setCellValue(emp.getStatus_division());
        }

        try {
            response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
            response.setHeader("Content-Disposition", "attachment;filename=employees.xlsx");
            workbook.write(response.getOutputStream());
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "엑셀 파일 생성 중 오류가 발생했습니다.");
        } finally {
            workbook.close();
        }
    }
    
	private String getRankDescription(int rank_code) {
	    switch (rank_code) {
	        case 1: return "사장";
	        case 2: return "이사";
	        case 3: return "팀장";
	        case 4: return "과장";
	        case 5: return "대리";
	        case 6: return "사원";
	        default: return "알 수 없음";
	    }
	}

	// 부서 코드를 설명으로 변환하는 메서드
	private String getDeptDescription(int dept_code) {
	    switch (dept_code) {
	        case 11: return "인사팀";
	        case 22: return "시설팀";
	        case 33: return "고객팀";
	        default: return "알 수 없음";
	    }
	}
}