package com.devpro.controller.admin;

import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.devpro.entities.SaleOrder;
import com.devpro.entities.User;
import com.devpro.repositories.SaleOrderRepo;
import com.devpro.repositories.UserRepo;
import java.time.DayOfWeek;
import java.util.Optional;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class GraphController {
        private final LocalDate today = LocalDate.now();
        private LocalDate startOfWeek = today.with(DayOfWeek.MONDAY);
        private LocalDate endOfWeek = today.with(DayOfWeek.SUNDAY);
        private String year = Integer.toString(today.getYear());
                
	@Autowired
	SaleOrderRepo saleOrderRepo; 
        @Autowired
        UserRepo userRepo;
        
        @PostMapping("/admin/choose-year")
        public String chooseYear(Model model, @RequestParam("yearSelect") String selectedYear){
            year = selectedYear;
            return "redirect:/admin/BarGraph";
        }
        
        @PostMapping("/admin/choose-week")
        public String chooseWeek(Model model, @RequestParam("mySelect") String localdate){
            startOfWeek = LocalDate.parse(localdate);
            endOfWeek = LocalDate.parse(localdate).plusDays(6);
            return "redirect:/admin/BarGraph";
        }
        
        LocalDate start_week =  today.with(DayOfWeek.MONDAY);
        LocalDate end_week =  today.with(DayOfWeek.SUNDAY);
        
	@GetMapping("/admin/BarGraph")
	public String barGraph(Model model) {
                
                model.addAttribute("start", startOfWeek);
                model.addAttribute("end", endOfWeek);
                model.addAttribute("startOfWeek",start_week);
                model.addAttribute("endOfWeek", end_week);
                List<Integer> top5userID = saleOrderRepo.findTop5userID();
                for(int i=0;i<top5userID.size();i++){
                    User username = userRepo.getOne(top5userID.get(i));
                    model.addAttribute("userID_"+Integer.toString(i), username.getUsername());
                }
                List<Integer> top5Total = saleOrderRepo.findTop5Total();
                for(int i=0;i<top5Total.size();i++){
                    model.addAttribute("total_"+Integer.toString(i), top5Total.get(i));
                }
                List<Integer> top5count = saleOrderRepo.findTop5OrderCount();
                for(int i=0;i<top5count.size();i++){
                    model.addAttribute("count_"+Integer.toString(i), top5count.get(i));
                }
                List<Integer> top5nvID = saleOrderRepo.findTop5CreatedID();
                for(int i=0;i<top5nvID.size();i++){
                    model.addAttribute("idnv_"+Integer.toString(i), top5nvID.get(i));
                }
                List<Integer> top5counthd = saleOrderRepo.findTop5OrderCreatedCount();
                for(int i=0;i<top5counthd.size();i++){
                    model.addAttribute("counthd_"+Integer.toString(i), top5counthd.get(i));
                }
                
		List<SaleOrder> saleOrders = saleOrderRepo.findAll();
		Map<String, Integer> saleOrder = new LinkedHashMap<>();
                Map<String, Integer> saleOrder_2 = new LinkedHashMap<>();
		int sum1 = 0,sum2 = 0,sum3 = 0,sum4 = 0,sum5 = 0,sum6 = 0,sum7 = 0,sum8 = 0,sum9 = 0,sum10 = 0,sum11 = 0,sum12 =0 ;
                int sumd_2 = 0, sumd_3 = 0, sumd_4 = 0, sumd_5 = 0, sumd_6 = 0, sumd_7 = 0, sumd_8 = 0;
		int sum = 0;
		int quantity = 0;   
		for (SaleOrder saleOrder1 : saleOrders) {
			
			LocalDateTime date =  saleOrder1.getCreatedDate();
                        boolean isWithinWeek = !date.toLocalDate().isBefore(startOfWeek) && !date.toLocalDate().isAfter(endOfWeek);
			Date out = Date.from(date.atZone(ZoneId.systemDefault()).toInstant());  // chuyển từ localdatetime về date
			
			SimpleDateFormat formatter = new SimpleDateFormat("EEE MMM dd HH:mm:ss zzz yyyy",Locale.ENGLISH);
			String dateFormat = formatter.format(out);                             // chuyển từ date về string
			sum = sum + saleOrder1.getTotal().intValue();
			for (int i = 0; i < saleOrder1.getSaleOrderProducts().size(); i++) {
				quantity =quantity +saleOrder1.getSaleOrderProducts().get(i).getQuantity();
			}
                        
			String month =  (String) dateFormat.subSequence(4, 7);
                        String weekday = (String) dateFormat.subSequence(0, 3);
                        String years = (String) dateFormat.subSequence(24, 28);
                        if (isWithinWeek){
                            if(weekday.equals("Mon")){
                                sumd_2 += saleOrder1.getTotal().intValue();
                            }
                            if(weekday.equals("Tue")){
                                sumd_3 += saleOrder1.getTotal().intValue();
                            }
                            if(weekday.equals("Wed")){
                                sumd_4 += saleOrder1.getTotal().intValue();
                            }
                            if(weekday.equals("Thu")){
                                sumd_5 += saleOrder1.getTotal().intValue();
                            }
                            if(weekday.equals("Fri")){
                                sumd_6 += saleOrder1.getTotal().intValue();
                            }
                            if(weekday.equals("Sat")){
                                sumd_7 += saleOrder1.getTotal().intValue();
                            }
                            if(weekday.equals("Sun")){
                                sumd_8 += saleOrder1.getTotal().intValue();
                            }
                        }
                                                
			if(month.equals("Jan") && years.equals(year)) {
				sum1 = sum1 + saleOrder1.getTotal().intValue();
			}
			if(month.equals("Feb") && years.equals(year)) {
				sum2 = sum2 + saleOrder1.getTotal().intValue();
			}
			if(month.equals("Mar") && years.equals(year)) {
				sum3 = sum3 + saleOrder1.getTotal().intValue();
			}
			if(month.equals("Apr") && years.equals(year)) {
				sum4 = sum4 + saleOrder1.getTotal().intValue();		
			}
			if(month.equals("May") && years.equals(year)) {
				sum5 = sum5 + saleOrder1.getTotal().intValue();		
			}
			if(month.equals("Jun") && years.equals(year)) {
				sum6 = sum6 + saleOrder1.getTotal().intValue();	
			}
			if(month.equals("Jul") && years.equals(year)) {
				sum7 = sum7 + saleOrder1.getTotal().intValue();				
			}
			if(month.equals("Aug") && years.equals(year)) {
				sum8 = sum8 + saleOrder1.getTotal().intValue();		
			}
			if(month.equals("Sep") && years.equals(year)) {
				sum9 = sum9 + saleOrder1.getTotal().intValue();		
			}
			if(month.equals("Oct") && years.equals(year)) {
				sum10 = sum10 + saleOrder1.getTotal().intValue();	
			}
			if(month.equals("Nov") && years.equals(year)) {
				sum11 = sum11 + saleOrder1.getTotal().intValue();	
			}
			if(month.equals("Dec") && years.equals(year)) {
				sum12 = sum12 + saleOrder1.getTotal().intValue();
			}
			
			System.out.println(dateFormat);
			System.out.println(month);
		}
		
		saleOrder.put("1", sum1);
		saleOrder.put("2", sum2);
		saleOrder.put("3", sum3);
		saleOrder.put("4", sum4);
		saleOrder.put("5", sum5);
		saleOrder.put("6", sum6);
		saleOrder.put("7", sum7);
		saleOrder.put("8", sum8);
		saleOrder.put("9", sum9);
		saleOrder.put("10", sum10);
		saleOrder.put("11", sum11);
		saleOrder.put("12", sum12);
                
                saleOrder_2.put("2", sumd_2);
                saleOrder_2.put("3", sumd_3);
                saleOrder_2.put("4", sumd_4);
                saleOrder_2.put("5", sumd_5);
                saleOrder_2.put("6", sumd_6);
                saleOrder_2.put("7", sumd_7);
                saleOrder_2.put("8", sumd_8);
                
		model.addAttribute("saleOrder", saleOrder);
                model.addAttribute("saleOrder_2", saleOrder_2);
		Locale locale = new Locale("vi", "VN");
		NumberFormat fmt = NumberFormat.getCurrencyInstance(locale);
		String sums = fmt.format(sum);
		model.addAttribute("sum", sums);
		model.addAttribute("quantity", quantity);
		return "admin/BarChart";
	}

}
