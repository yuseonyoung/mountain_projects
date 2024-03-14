package egovframework.burin.cmmn.statistics.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/statistics")
public class StatisticController {
	@GetMapping("/regionView.do")
	public String regionStatistics() {
		log.info("여기오는지 확인");
		return "statistics/region";
	}
}
