package jp.co.seattle.library.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import jp.co.seattle.library.dto.BookInfo;
import jp.co.seattle.library.service.BooksService;

/**
 * Handles requests for the application home page.
 */
@Controller // APIの入り口
public class LibraryController {
	final static Logger logger = LoggerFactory.getLogger(LibraryController.class);

	@Autowired
	private BooksService booksService;

	/**
	 * Homeボタンからホーム画面に戻るページ
	 * 
	 * @param model
	 * @return
	 */

	@RequestMapping(value = "/library", method = RequestMethod.GET)
	public String getLibrarybooks(Model model) {

		//お気に入りの取得

		List<BookInfo> librarianBookList = booksService.librarybooks();

		if (librarianBookList.isEmpty()) {
			String message = "在庫がある書籍はありません";
			model.addAttribute("resultMessage", message);
		} else {
			model.addAttribute("bookList", librarianBookList);

		}
		return "library";

	}

}