package jp.co.seattle.library.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import jp.co.seattle.library.dto.BookInfo;
import jp.co.seattle.library.service.BooksService;

/**
 * Handles requests for the application home page.
 */
@Controller // APIの入り口
public class HomeController {
	final static Logger logger = LoggerFactory.getLogger(HomeController.class);

	@Autowired
	private BooksService booksService;

	private String tagserching;

	/**
	 * Homeボタンからホーム画面に戻るページ
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/home", method = RequestMethod.GET)
	public String transitionHome(Model model) {
		//書籍の一覧情報を取得（タスク３）

		List<BookInfo> getedBookList = booksService.getBookList();
		model.addAttribute("bookList", getedBookList);
		if (getedBookList.isEmpty()) {
			String errormessage = "書籍データが0件です";
			model.addAttribute("resultMessage", errormessage);
		}
		return "home";

	}

	@RequestMapping(value = "/search", method = RequestMethod.GET)
	public String searchbooks(@RequestParam("search") String searching, Model model) {

		//検索情報の取得

		List<BookInfo> searchedBookList = booksService.searchbookList(searching);
		if (searchedBookList.isEmpty()) {
			String errormessage = "書籍データが0件です";
			model.addAttribute("resultMessage", errormessage);
		} else {
			model.addAttribute("bookList", searchedBookList);
		}

		return "home";
	}

	//お気に入り登録情報の取得
	@RequestMapping(value = "/fav", method = RequestMethod.GET)
	public String favorite(@RequestParam("bookId") int bookId, Model model) {
		booksService.getFavorite(bookId);
		return "redirect:/home";
	}

	@RequestMapping(value = "/notfav", method = RequestMethod.GET)
	public String notfavorite(@RequestParam("bookId") int bookId, Model model) {
		booksService.getnotFavorite(bookId);
		return "redirect:/home";

	}

	//
	@RequestMapping(value = "tag", method = RequestMethod.GET)
	public String tag(@RequestParam("bookId") int bookId, Model model) {
		booksService.getFavorite(bookId);
		return "redirect:/home";
	}

	@RequestMapping(value = "/tagsearch", method = RequestMethod.GET)
	public String tagsearchbooks(@RequestParam("tagsearch") String tagsearching, Model model) {

		//タグ検索情報の取得
		List<BookInfo> tagsearchedBookList = booksService.tagsearchBookList(tagsearching);
		{
			if (tagsearchedBookList.isEmpty()) {
				String errormessage = "書籍データが0件です";

				model.addAttribute("resultMessage", errormessage);
			} else {

				model.addAttribute("bookList", tagsearchedBookList);
			}

			return "home";
		}
	}

	@RequestMapping(value = "/search_order", method = RequestMethod.GET)
	public String search_orderbooks(@RequestParam("search_order") String searchordered, Model model) {

		//書籍表示順バリエーションタグ検索情報の取得
		if (searchordered.equals("orderASC")) {
			List<BookInfo> selectedBookInfo = booksService.orderBookListASC();
			model.addAttribute("bookList", selectedBookInfo);
		}
		if (searchordered.equals("orderDESC")) {
			List<BookInfo> selectedBookInfo = booksService.orderBookListDESC();
			model.addAttribute("bookList", selectedBookInfo);
		}
		if (searchordered.equals("book_author")) {
			List<BookInfo> selectedBookInfo = booksService.authorBookList();
			model.addAttribute("bookList", selectedBookInfo);
		}
		if (searchordered.equals("book_publish_date")) {
			List<BookInfo> selectedBookInfo = booksService.publish_DateBookList();
			model.addAttribute("bookList", selectedBookInfo);
		}
		return "home";
	}

	//貸し出し機能情報の取得

	@RequestMapping(value = "/stock", method = RequestMethod.POST)
	public String library(@RequestParam("bookId") int bookId, @RequestParam("value") String value, Model model) {
		booksService.getLibrary(value, bookId);
		return "redirect:/home";

	}
}