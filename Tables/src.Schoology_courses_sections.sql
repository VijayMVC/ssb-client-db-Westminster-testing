CREATE TABLE [src].[Schoology_courses_sections]
(
[SK] [bigint] NULL,
[ETL__multi_query_value_for_audit] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[section_id] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[course-title] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[course-code] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[course-id] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[school-id] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[access-code] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[section-title] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[section-code] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[section-school-code] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[synced] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[active] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[description] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[parent-id] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[profile-url] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[location] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[start-time] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[end-time] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[weight] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[admin] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[meeting-days_] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[grading-periods_] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[options_weighted-grading-categories] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[upload-documents] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[create-discussion] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[member-post] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[member-post-comment] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[default-grading-scale-id] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[hide-overall-grade] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[hide-grading-period-grade] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[allow-custom-overall-grade] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[allow-custom-overall-grade-text] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[cross-listed-section-school-codes_] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[visibility_topics] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[visibility_assignments] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[visibility_assessments] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[visibility_new-test-quiz] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[visibility_common-assessments] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[visibility_documents] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[visibility_discussion] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[visibility_album] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[visibility_pages] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
