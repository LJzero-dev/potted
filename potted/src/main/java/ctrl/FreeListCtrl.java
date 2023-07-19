package ctrl;

import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;


@Controller
public class FreeListCtrl {
	@GetMapping("/freeList")
	public String freeListCtrl() {
		return "freeList/freeList";
	}
}

