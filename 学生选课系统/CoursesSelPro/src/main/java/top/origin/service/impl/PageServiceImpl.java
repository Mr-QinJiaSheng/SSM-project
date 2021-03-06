package top.origin.service.impl;

import org.springframework.stereotype.Service;
import top.origin.model.Page;
import top.origin.service.PageService;

import java.util.List;

@Service
public class PageServiceImpl implements PageService {
    @Override
    public Page subList(int page, List list) {
        Page paging = new Page();
        paging.setCurrentPage(page);
        int count = list.size();
        paging.setTotalPage(count % 6 == 0 ? count / 6 : count / 6 + 1);
        paging.setPageSize(6);
        paging.setStar((paging.getCurrentPage() - 1) * paging.getPageSize());
        paging.setDataList(list.subList(paging.getStar(), count - paging.getStar() > paging.getPageSize() ? paging.getStar() + paging.getPageSize() : count));
        return paging;
    }
}
