

test_that("An colortable from an annotation can be written to a text file in FreeSurfer LUT format.", {
  annotfile = system.file("extdata", "lh.aparc.annot.gz", package = "freesurferformats", mustWork = TRUE);
  annot = read.fs.annot(annotfile);

  output_file = tempfile();
  write.fs.colortable.from.annot(output_file, annot);

  written_cmap_df = read.fs.colortable(output_file);
  expect_equal(nrow(written_cmap_df), 36);
  expect_equal(ncol(written_cmap_df), 6);

  region_unknown = subset(written_cmap_df, written_cmap_df$struct_name == "unknown");
  expect_equal(region_unknown$struct_index, 0);
  expect_equal(region_unknown$r, 25);
  expect_equal(region_unknown$g, 5);
  expect_equal(region_unknown$b, 25);
  expect_equal(region_unknown$a, 0);
})


test_that("An annotation can be written in binary v2 format and read again.", {
  annotfile = system.file("extdata", "lh.aparc.annot.gz", package = "freesurferformats", mustWork = TRUE);
  annot = read.fs.annot(annotfile);

  output_file = tempfile(fileext = ".annot");
  write.fs.annot(output_file, length(annot$vertices), annot$colortable_df, labels_as_colorcodes=annot$label_codes);

  annot2 = read.fs.annot(output_file);

  expect_equal(annot$vertices, annot2$vertices);
})