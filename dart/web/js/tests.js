/**
 * @fileoverview Qunit test functions for familypics.js 
 */

test("getDirectories", 2, function() {
  //specifies the number of assertions(ok(), equals(), same()) that should follow for this test
  //can also pass as second argument to test()
  //expect(4);

  subdirectories = getDirectories("/");
  equal(subdirectories[0], '2013-02', 'the first root directory is 2013-01');
  equal(subdirectories.length, 105, 'root pic directory contains 105 non-hidden directories');
  //ok(subDirectories.);
  
  // getDirectories("2013-01");
  // getDirectories("_Samples");
  // getDirectories("bogus-directory");
  //ok(getDirectories("/") == )
});


//not used/implemented on the server-side
test("getThumb", 1, function() {
  ok(getThumb("2013-01/bogus.jpg") == '', "bogus file search failed" );
});


test("loadThumbnails", function() {
  loadThumbnails("2013-01");
    var imgs = document.getElementById("qunit-fixture").getElementsByTagName("img");
    equal(imgs[0].getAttribute("title"), "DSC05644.JPG");
    equal(imgs[20].getAttribute("title"), "DSC05645.JPG");
    equal(imgs[21], undefined);
    equal(imgs.length, 21);
    var subtitle = document.getElementById("subtitle");
    equal(subtitle.innerHTML, "2013-01")
    
  // loadThumbnails("bogus");
    // equal();
});
