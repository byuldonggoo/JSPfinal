use test;

select * from board_t;
select * from user_t;
select * from kakaouser_t;
select * from goods_t;

CREATE TABLE `board_t` (
  `num_aticle` int(11) NOT NULL AUTO_INCREMENT,
  `nickname` varchar(20) NOT NULL,
  `category` varchar(10) NOT NULL,
  `title` text NOT NULL,
  `contents` text NOT NULL,
  `deal_status` int(11) DEFAULT 0,
  `upload` datetime DEFAULT current_timestamp(),
  `goods_name` varchar(20) NOT NULL,
  `num_cmnt` int(11) DEFAULT NULL,
  PRIMARY KEY (`num_aticle`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `goods_t` (
  `num_aticle` int(11) NOT NULL,
  `price` text NOT NULL,
  `goods_img` text NOT NULL,
  `tag` text DEFAULT NULL,
  PRIMARY KEY (`num_aticle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `kakaouser_t` (
  `id` varchar(20) NOT NULL,
  `nickname` varchar(20) NOT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  `profile_img` text DEFAULT NULL,
  `addr` text DEFAULT NULL,
  `detail_addr` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nickname` (`nickname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `user_t` (
  `id` varchar(20) NOT NULL,
  `password` varchar(30) NOT NULL,
  `nickname` varchar(20) NOT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  `profile_img` text DEFAULT NULL,
  `addr` text DEFAULT NULL,
  `detail_addr` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nickname` (`nickname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

delete from kakaouser_t where nickname="조민지";