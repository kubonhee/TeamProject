package net.yangchoo.service;

import net.yangchoo.domain.EmailDTO;

public interface EmailService {
	public int sendMail(EmailDTO dto);

}
