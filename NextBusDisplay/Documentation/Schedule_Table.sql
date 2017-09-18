CREATE TABLE dbo.[????]
(
    TblID           INT IDENTITY(1,1) NOT NULL,
    InternalID      VARCHAR(10) NOT NULL,
    route_id        VARCHAR(50) NOT NULL,       -- dbo.routes r     route_id
    Route_Name      VARCHAR(50) NOT NULL,       -- dbo.routes r     ISNULL(NULLIF(r.route_short_name, ''), r.route_long_name) Route_Name
-- ??    service_id      VARCHAR(50) NULL,           -- dbo.calendar c   service_id
    monday          BIT NULL,                   -- dbo.calendar c   monday
    tuesday         BIT NULL,                   -- dbo.calendar c   tuesday
    wednesday       BIT NULL,                   -- dbo.calendar c   wednesday
    thursday        BIT NULL,                   -- dbo.calendar c   thursday
    friday          BIT NULL,                   -- dbo.calendar c   friday
    saturday        BIT NULL,                   -- dbo.calendar c   saturday
    sunday          BIT NULL,                   -- dbo.calendar c   sunday
)


-- 618 SPRINTER - M-F
-- 618 SPRINTER - Sa-Su h
-- 620 SPRINTER - M-F
-- 620 SPRINTER - Sa-Su h

-- 630 COASTER  - M-F
-- 634 COASTER  - M-F
-- 636 COASTER  - M-F
-- 638 COASTER  - M-F
-- 640 COASTER  - M-F
-- 644 COASTER  - M-F
-- 648 COASTER  - M-F
-- 654 COASTER  - M-F
-- 656 COASTER  - M-F
-- 660 COASTER  - M-F
-- 662 COASTER  - M-F
-- 664 COASTER  - F
-- 672 COASTER  - F
-- 680 COASTER  - Sa
-- 684 COASTER  - Sa
-- 688 COASTER  - Sa
-- 690 COASTER  - Sa
-- 692 COASTER  - Sa
-- 696 COASTER  - Sa
-- 680 COASTER  - Su / h
-- 684 COASTER  - Su / h
-- 688 COASTER  - Su / h
-- 692 COASTER  - Su / h
-- 631 COASTER  - M-F
-- 635 COASTER  - M-F
-- 639 COASTER  - M-F
-- 645 COASTER  - M-F
-- 651 COASTER  - M-F
-- 653 COASTER  - M-F
-- 655 COASTER  - M-F
-- 657 COASTER  - M-F
-- 661 COASTER  - M-F
-- 663 COASTER  - M-F
-- 665 COASTER  - M-F
-- 671 COASTER  - F
-- 675 COASTER  - F
-- 681 COASTER  - Sa
-- 685 COASTER  - Sa
-- 689 COASTER  - Sa
-- 691 COASTER  - Sa
-- 693 COASTER  - Sa
-- 697 COASTER  - Sa
-- 681 COASTER  - Su / h
-- 685 COASTER  - Su / h
-- 689 COASTER  - Su / h
-- 693 COASTER  - Su / h
-- 652 COASTER  - Padres
-- 699 COASTER  - Padres
