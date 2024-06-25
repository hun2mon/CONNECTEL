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
        headerRow.createCell(4).setCellValue("재직상태");

        for (EmpDTO emp : employees) {
            Row row = sheet.createRow(rowIdx++);
            row.createCell(0).setCellValue(emp.getEmp_no());
            row.createCell(1).setCellValue(emp.getName());
            row.createCell(2).setCellValue(emp.getDept_code());
            row.createCell(3).setCellValue(emp.getRank_code());
            row.createCell(4).setCellValue(emp.getStatus_division());
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
}