package top.origin.service;

import top.origin.model.Page;

import java.util.List;

public interface PageService {
    Page subList(int page, List list);
}
