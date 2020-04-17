// Auto-generated
let project = new Project('ld46');

project.addSources('Sources');
project.addLibrary("/home/tong/sdk/ArmorySDK/armory");
project.addLibrary("/home/tong/sdk/ArmorySDK/iron");
project.addLibrary("/home/tong/sdk/ArmorySDK/lib/haxebullet");
project.addAssets("/home/tong/sdk/ArmorySDK/lib/haxebullet/ammo/ammo.wasm.js", { notinlist: true });
project.addAssets("/home/tong/sdk/ArmorySDK/lib/haxebullet/ammo/ammo.wasm.wasm", { notinlist: true });
project.addParameter('ld46.scene.Game');
project.addParameter("--macro keep('ld46.scene.Game')");
project.addParameter('armory.trait.WalkNavigation');
project.addParameter("--macro keep('armory.trait.WalkNavigation')");
project.addParameter('ld46.scene.Mainmenu');
project.addParameter("--macro keep('ld46.scene.Mainmenu')");
project.addParameter('armory.trait.internal.DebugConsole');
project.addParameter("--macro keep('armory.trait.internal.DebugConsole')");
project.addParameter('armory.trait.internal.Bridge');
project.addParameter("--macro keep('armory.trait.internal.Bridge')");
project.addParameter('ld46.scene.Boot');
project.addParameter("--macro keep('ld46.scene.Boot')");
project.addParameter('armory.trait.physics.bullet.PhysicsWorld');
project.addParameter("--macro keep('armory.trait.physics.bullet.PhysicsWorld')");
project.addShaders("build_ld46/compiled/Shaders/*.glsl", { noembed: false});
project.addAssets("build_ld46/compiled/Assets/**", { notinlist: true });
project.addAssets("build_ld46/compiled/Shaders/*.arm", { notinlist: true });
project.addAssets("/home/tong/sdk/ArmorySDK/armory/Assets/brdf.png", { notinlist: true });
project.addAssets("/home/tong/sdk/ArmorySDK/armory/Assets/hosek/hosek_radiance.hdr", { notinlist: true });
project.addAssets("/home/tong/sdk/ArmorySDK/armory/Assets/hosek/hosek_radiance_0.hdr", { notinlist: true });
project.addAssets("/home/tong/sdk/ArmorySDK/armory/Assets/hosek/hosek_radiance_1.hdr", { notinlist: true });
project.addAssets("/home/tong/sdk/ArmorySDK/armory/Assets/hosek/hosek_radiance_2.hdr", { notinlist: true });
project.addAssets("/home/tong/sdk/ArmorySDK/armory/Assets/hosek/hosek_radiance_3.hdr", { notinlist: true });
project.addAssets("/home/tong/sdk/ArmorySDK/armory/Assets/hosek/hosek_radiance_4.hdr", { notinlist: true });
project.addAssets("/home/tong/sdk/ArmorySDK/armory/Assets/hosek/hosek_radiance_5.hdr", { notinlist: true });
project.addAssets("/home/tong/sdk/ArmorySDK/armory/Assets/hosek/hosek_radiance_6.hdr", { notinlist: true });
project.addAssets("/home/tong/sdk/ArmorySDK/armory/Assets/hosek/hosek_radiance_7.hdr", { notinlist: true });
project.addAssets("/home/tong/sdk/ArmorySDK/armory/Assets/smaa_area.png", { notinlist: true });
project.addAssets("/home/tong/sdk/ArmorySDK/armory/Assets/smaa_search.png", { notinlist: true });
project.addAssets("Bundled/font/helvetica_neue_75.ttf", { notinlist: false });
project.addAssets("Bundled/index.html", { notinlist: true });
project.addShaders("/home/tong/sdk/ArmorySDK/armory/Shaders/debug_draw/**");
project.addParameter('--times');
project.addLibrary("/home/tong/sdk/ArmorySDK/lib/zui");
project.addAssets("/home/tong/sdk/ArmorySDK/armory/Assets/font_default.ttf", { notinlist: false });
project.addDefine('arm_hosek');
project.addDefine('arm_deferred');
project.addDefine('arm_csm');
project.addDefine('arm_clusters');
project.addDefine('rp_hdr');
project.addDefine('rp_renderer=Deferred');
project.addDefine('rp_shadowmap');
project.addDefine('rp_shadowmap_cascade=2048');
project.addDefine('rp_shadowmap_cube=512');
project.addDefine('rp_background=World');
project.addDefine('rp_render_to_texture');
project.addDefine('rp_compositornodes');
project.addDefine('rp_antialiasing=SMAA');
project.addDefine('rp_supersampling=1');
project.addDefine('rp_ssgi=SSAO');
project.addDefine('rp_voxelao');
project.addDefine('rp_voxelgi_resolution=64');
project.addDefine('rp_voxelgi_resolution_z=0.5');
project.addDefine('arm_audio');
project.addDefine('arm_physics');
project.addDefine('arm_bullet');
project.addDefine('arm_noembed');
project.addDefine('arm_soundcompress');
project.addDefine('arm_debug');
project.addDefine('arm_ui');
project.addDefine('arm_skin');
project.addDefine('arm_particles');

///// LD46 - DEV ------------------

project.addDefine('dev');


resolve(project);
