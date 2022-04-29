CREATE TABLE `lottery` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`identifier` VARCHAR(40) DEFAULT NULL,
	`type` VARCHAR(20) NOT NULL,
	`run` INT NOT NULL,
	`win` INT NOT NULL,

	PRIMARY KEY (`id`)
);

CREATE TABLE `lottery_wins` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`identifier` VARCHAR(40) DEFAULT NULL,
	`type` VARCHAR(20) NOT NULL,
	`price` INT NOT NULL,
	`claimed` INT NOT NULL,

	PRIMARY KEY (`id`)
);