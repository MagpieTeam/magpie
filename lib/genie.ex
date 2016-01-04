defmodule Magpie.Genie do
  def gen_loggers() do
    logger_ids()
    |> Enum.with_index()
    |> Enum.each(fn({id, index}) -> 
         IO.puts("INSERT INTO magpie.loggers (id, name, password) VALUES (" <> id <> ", 'TESTLOGGER" <> to_string(index) <> "', '1234');")
       end)
  end

  def gen_sensors() do
    sensors = 
      logger_ids()
      |> Enum.reduce([], fn(logger_id, acc) ->
         statements =
           gen_sensor_ids()
           |> Enum.with_index()
           |> Enum.map(fn({id, index}) -> 
                "INSERT INTO magpie.sensors (logger_id, id, name, unit_of_measure, active) VALUES (#{logger_id}, #{id}, 'TESTSENSOR#{index}', 'V', true);\n"
              end)
          statements ++ acc
       end)
  end

  def gen_sensor_ids() do
    for _x <- 0..100 do
      :uuid.get_v4() |> :uuid.uuid_to_string() |> to_string()
    end
  end

  def logger_ids() do
    [
      "ad9cdf0f-c167-4df1-9024-9bf20be7defa",
      "f9bca91f-8af0-46b2-a1ec-6aa0dc6d2f48",
      "05e15999-ae8b-4b1f-a7da-50f127950e80",
      "f3636aed-9e44-47fa-89db-85ed633865f2",
      "3da1e778-62e9-458c-9b5c-f28c16d43577",
      "1c8e8ddc-9c3c-4ed3-a634-d21ebd769172",
      "e4efdb67-7258-4256-b3c1-5f2285982c27",
      "a6cd8f7e-8ef2-478c-aa8e-50f2f09417df",
      "2c6f9580-8077-49d6-8e0c-58cc65db5145",
      "5d87306a-31e6-4502-8e1d-c5b144a00cbe",
      "0c49157d-0da4-4316-9187-aa56b438f994",
      "cefa7972-4c09-467c-9b0b-b6ffbd83f841",
      "724da7ce-d824-4918-bbe7-21634ab77dda",
      "ea0f3240-28e3-4a8e-aaf2-8223e6e9ed84",
      "727037b6-7ba1-48e3-a8e9-fe99094173dc",
      "2bf3caaf-a186-43d1-afb6-7b66ec4f9bc0",
      "44e9e13b-8c37-4b07-af01-8641b16b1d87",
      "b5d8bfbb-34ca-45b1-845f-6470afc4ed9a",
      "ca136765-fa54-467c-816b-4aa46e6d567a",
      "9a91fd8b-6372-4988-848f-d637d742a6bb",
      "7f8425b9-1e95-4d93-9e84-fc8c37ee975f",
      "5590391d-fd22-4ea2-8e39-d0338d05ec54",
      "9b50a27e-da79-46b6-806d-e79a92b0ae98",
      "10bc4df9-0d37-4a39-b735-c960da7b5af2",
      "9d919170-a2f5-40d6-b214-8f4e876be9b6",
      "70a6b961-ab05-41a3-baec-191190c60309",
      "4521bede-08fe-4d47-a2e7-688412726422",
      "cc143dff-886c-47fc-8dc9-9ccf73659265",
      "bb4bc9f0-c103-4749-944c-389710303d85",
      "339fc871-7a6b-45f6-8dd7-ddf055213b61",
      "1767521f-74db-4dc7-a48e-f197eab4aa73",
      "d7f2df2e-60f9-4ef9-891e-1495f6d1362c",
      "c774d7fd-429b-45ec-acca-0ec4ba6b8409",
      "cef3b4c2-aa4b-49ab-8092-74408ed83370",
      "d5189632-13bd-4d34-ae4a-4a5bf1a9c70e",
      "474fb506-3d3e-41e6-9e8a-8fca6d2cb373",
      "03b811ad-1473-4735-aaff-118f32f506ad",
      "c8cef95d-a564-4cc8-a9f8-82c5649d6d79",
      "cf8215a5-e58d-4706-b13b-85dcbfa634b8",
      "8b612d6f-dd81-42c5-b3cd-e13fe5b08188",
      "2dbb8190-71e0-4a1d-aa2a-7783485a8471",
      "4a8d34a2-46c3-41a1-b394-1317509ead23",
      "86200ab5-35af-428c-9420-216464662d4b",
      "d9557503-039a-457a-a94a-5932b8e874d3",
      "02b7d6a0-1b8c-48bc-9217-6df8369a18e4",
      "d66aa469-e0cf-4400-98c7-8eb77eeeea02",
      "2d03031c-ae19-4a99-8a7d-99c0e813cf6e",
      "b3a745bd-3fcd-49aa-96a1-5b97aa411bfb",
      "135a6039-7922-4d5e-b9e9-7cc06e46e75c",
      "38de5130-7f08-4b70-acb3-ca8f96cf1bb9",
      "1e2d4e72-6870-474f-b96a-46127845f26b",
      "c287eba3-d543-4996-9d9d-cb773798fcb3",
      "89d2ad85-23d5-484d-bb14-e09c8f77d0dd",
      "bc2f7662-d5bc-4316-84bb-4fc1dc0dce01",
      "b1565810-1054-4cb4-a2d5-1c042262b4d7",
      "13b14e6d-754b-4b31-a958-0d3ade7765dc",
      "baf8fbf4-7441-4790-b87f-7084fd55aa6d",
      "500ba9e5-5ef2-40c4-9351-45de4fef2f30",
      "34c7fff7-a528-4b8d-9b63-e75dd21bee28",
      "757883e2-05db-4675-914e-745d12736b5f",
      "13f3420b-f29f-4f1d-9d95-2b1e09fed2a1",
      "b8414569-0240-44d1-886f-f93358857004",
      "2ea7f39a-f22f-4d50-b601-efc524289ea6",
      "7bcf78bc-ace2-4480-82bc-716bb998884a",
      "90269ab3-2931-4a40-82d2-73d487ac0c3c",
      "2580a70e-2e52-43ab-95ea-afd585badf05",
      "ea64ea06-c0ec-44e6-abcc-26c40c593ee2",
      "2ca66d3d-ae88-44db-92b8-8d25384dee2e",
      "7c8968a0-879c-4c82-b803-fcf5bb4076ba",
      "bc0146f5-0372-4f79-a557-4e4928e94f54",
      "e3d4834b-c353-43fb-848c-04bab099b698",
      "dc25d5d3-5830-41df-b1d1-22c729a33078",
      "53d5ba86-2f50-443f-992c-9dc9a2062ef0",
      "5caab543-efc3-40e5-b827-75350f113e1c",
      "729d6109-20ab-4217-98b0-5414aa7d0021",
      "210a186b-5006-4a9b-b1ee-9b21ad1f09c4",
      "6cb66aa7-c915-42f6-a7cc-3c37b376feb8",
      "0dd9529e-c22e-45ef-ad83-2b4bbd86ba70",
      "7b976caf-4c8e-41f5-970f-8b9cdb737365",
      "b7ec80ac-43ff-4cd9-993f-29c0e4473f5d",
      "f975fdb9-a133-46bf-a4c8-2c674aee97c1",
      "f886ffeb-5bb6-4d5d-954d-5b0fc0eaeb6f",
      "05d66cdb-164e-4212-bcfa-ba8991011c70",
      "2ae0cda9-6d9e-4625-909b-0baf877bc85e",
      "25b021f3-47ad-42c9-a56b-5f624238b3ec",
      "fddc73cf-e8d1-406f-91f7-d2de8677d362",
      "d25e60cc-08ed-48ac-9b4b-cbd917f836a9",
      "72cc8cbc-1157-4283-9ef1-bf5e56052b55",
      "83a311d7-f296-45d8-9e9a-37f7fea0783e",
      "86dd1b77-94b6-4a23-94e9-6cfee5a2785f",
      "98aefbf3-e517-49d9-a87b-ae830245778a",
      "8ff36b7a-7e2f-435c-a245-da1beea6a9e4",
      "c34d2efd-63cf-4e38-a008-8ede058ed5df",
      "dfc24320-cb6f-4414-92f6-aaa229e2550d",
      "58ab15ff-b0fe-4200-bd88-897720e31467",
      "74016b37-2f66-49ec-9fc0-0e70f4e5db9e",
      "2211c723-9478-440a-8026-73f170d7384a",
      "b1a7a603-7055-4ae2-8e59-751b8daab2d6",
      "91167970-0310-46da-9f25-c7145cbf9e41",
      "aade6a44-ba1c-4251-8827-a22c28cef75b",
      "0ef4784b-5316-4abc-a96a-d774d6461804",
      "eef5dbe8-9ef7-4018-8b39-9a57c7497910",
      "a4c8165f-f615-4ab7-a454-c8ff89a94612",
      "4b234ae2-b5b0-43ab-8451-2ea86c78f03f",
      "2fe62870-b25c-4b3c-8408-e028cbf7be66",
      "e31ad4b4-1f70-49c0-bcf7-c63d66aef563",
      "c3ba5d65-f5c0-4a90-b4ff-faeb7f7f2f9c",
      "7df9224b-0731-47a7-80c9-3adfd5a011bc",
      "0db3b86f-742e-403c-b001-04922c5baff7",
      "b62fd246-7d7e-4e8d-bc9a-3b7aa95eed52",
      "dac56f9f-184b-4307-b86d-8932b1827476",
      "71ba9f90-915d-4dbd-8d44-81fe28da1f7e",
      "4a613a6c-ec74-4162-8d4c-5b8717b7e522",
      "9da76898-d7b2-45e1-b80c-fb503df0ca8d",
      "acfa0d7b-b602-4f02-8cb9-34e66f2fb3d1",
      "05c5a737-e8ef-4bc7-8482-91c6d3b752cc",
      "0639cb85-03cc-46bc-b4a5-a93fbb6e0156",
      "6070f55e-24b9-49f4-a3c9-b633eb424f92",
      "0a0bda9d-a3bc-4451-9ddc-0fb6e949c939",
      "014d07d2-4aeb-4140-ba4f-cf941fdfeda1",
      "66bb4406-cb57-406b-ba64-85acfa974dbb",
      "1c1324a8-77f8-4ac5-988b-5be448e6e9e1",
      "6f190b81-a298-4ff7-8e9b-7045590bbeb6",
      "c36732c8-a4fc-45e8-957f-76d6c8998d46",
      "9668b508-d026-486b-a59c-80be74ca95ea",
      "03cd5e71-bb8a-41e1-a22f-a4965f508408",
      "ca60e36b-e10d-4740-9634-d361af5f3c7f",
      "d481aab7-4b0d-4fc2-81c4-9ad46388c0fa",
      "c31891a7-0ba6-400f-b0fe-8ac7139b830b",
      "6e798294-0344-4a9e-93fa-5d4a80dbd9f4",
      "01a24b37-15de-4b29-9c5b-e4faa282b482",
      "b631f782-d763-43ae-8d58-b75a6d8fe4cd",
      "acd1dc61-f3c1-454b-b4f2-a0753ac90072",
      "1aa44be1-470e-498d-95d3-ea3b7bde8e16",
      "6fabd956-acaa-4eae-a1ac-19647986c79f",
      "1dba40be-73e9-478c-820f-2f5482845292",
      "aae2f5c8-7232-490a-9e48-4fe494fa0f3f",
      "06d749b8-f6d0-431d-83fa-2fa70b7a3f02",
      "75eec820-393c-4cff-8d6c-ca2ab55b48ce",
      "478fa055-01df-438d-b9de-f7434c41762e",
      "3dbd2784-e874-48f6-90f9-638758a1fa63",
      "7dca4b27-35d7-4e6d-9ac4-e56996832624",
      "2b187113-21e0-49cf-990c-3c5057514012",
      "1787e985-8856-4ff8-bc61-63344344ca03",
      "8b863f4b-6761-41a2-a24a-bfd95b9e83a3",
      "9b90391a-9fc1-461b-a9d8-34e9fc4d08a8",
      "19f8bf5d-6752-463f-a359-92ad5dee00a3",
      "9af2135b-b01f-400d-8471-81298f8d758b",
      "342c7f36-daca-4a43-8dba-b029f376ab4f",
      "3cbe887d-d729-4b5e-bc0c-9d9982b815b2",
      "945a9b51-52e7-4ea2-b7b7-f62e2dfa1cde",
      "31163b6e-3980-46fd-b80e-56ce70e87ddb",
      "fe68a97f-87e1-481e-bf36-3bdfd6287acc",
      "b7dd85f2-80a9-42f0-816f-289b68aa90aa",
      "cabe3fa1-bf81-4ef4-99e6-d5e13cf12740",
      "8febb5d5-93a0-4ebe-a567-efb5f4a1d540",
      "dde7a86d-df86-44df-805d-dd45884fa23c",
      "27c46689-3fa0-43b8-af15-a8188d71b72d",
      "534cdf82-fac6-4d82-90b6-e274127064f3",
      "198020e7-3d33-4f93-86be-dad22dbf62c6",
      "7449d238-b1c5-433f-a8be-cc15bc6791c1",
      "b4d40de7-a091-40d3-ad82-182a3892b78f",
      "d9126230-f11a-4b7a-8ae2-d8431bbcb4b2",
      "14e40030-83ed-4d85-a06f-4adfdca93802",
      "514aa8a2-1d35-48a1-836d-82e5e2d1ec15",
      "558ccb79-1bdb-40fa-bdf3-13eb6718eac1",
      "dd76ba6c-5ddb-4648-bbef-3e50aa92a085",
      "3fcb3c51-b385-42fc-8b79-e7d541c20c00",
      "823975e4-2a1e-4cd7-8660-954f4e388f9c",
      "81cc36fb-7baf-4441-b50e-9f03ada7b098",
      "62f78bcd-fe0a-45ba-bf8a-212c2a7f63e4",
      "43f2450e-bbf5-4d3a-89bd-a6fc39b319ef",
      "2f02d5a2-9560-420c-8fc7-e1c1adbfc896",
      "f873fb46-fe24-47a6-88ef-c5ba05e7a093",
      "1a5c56fc-f293-4f98-b8c7-592f2dd9af1a",
      "dac9e794-1f28-46c9-9cb0-51623a98d288",
      "f52bf8e6-86ed-4590-8200-1f054cfd0762",
      "982d9948-4fda-4484-8b36-b13476105e70",
      "5acdd9ad-5b38-4046-a48e-ff22396ebb3d",
      "b701f521-b650-4de9-8534-62826b706f0f",
      "7f9e65bf-e269-453f-90d8-acb7c91494b3",
      "cccc70d1-b860-4515-8065-3419c2a47e43",
      "855026a4-4381-4a43-9ab5-e8b7cece1f0f",
      "0309448a-fe63-45ed-a2a1-73846c1dfeaf",
      "a19b98a8-df46-40cb-9308-e25281e47c9a",
      "78399274-c8e6-450c-bad5-53d4f75a4b3c",
      "ab29c325-092f-4366-b819-a8500394e527",
      "96953851-df79-48ec-bedf-72d7792b2f12",
      "5078d141-85cc-434f-86af-f61e726efc47",
      "1515c87b-1add-4ebd-b502-9625faef4fa0",
      "beb1bbcb-fe1d-4e2e-8a32-dd9c00e9d713",
      "77efc29a-b4a5-4435-b47c-9efdea568002",
      "5082e86e-d91a-4fca-bb7d-f5d156ff7c21",
      "dedb6606-c263-4df4-ac1c-e733609ad76e",
      "33603d06-cf63-4dc7-b096-e6de28e6e9ea",
      "c0bf443a-4756-4fd5-91c4-c37b6a7b6137",
      "4bd0b277-7fd8-4dfc-b337-c60f72b84321",
      "14629e79-995b-4352-a554-cf83eff2ac34",
      "31e6b6b2-eafd-4697-b4f2-a7c9f65fa36a",
      "55ca04e3-e24c-4007-9090-2cbb4d0c7a70",
      "85cfa321-7e39-4e49-809d-bb98e7cfda94",
      "4ebfe1bc-e91b-4bd2-8d91-862c4a705064",
      "177fd2ee-96c9-41dd-bfdb-7cfa08a7373e",
      "8ba616b8-eae6-4dd6-b363-6077aa359ce0",
      "1c778c34-3ecd-4897-8f51-3739e633d2a2",
      "9a414e45-ac28-443c-98ec-19960b3a7a5a",
      "3ee0021b-a151-4b7a-941c-57c60c7d58ba",
      "15e29d15-9b26-4b4e-a68d-320247c97b46",
      "8e4db284-cc95-40d4-9f3f-28128ed25d03",
      "7a9f2e8e-e783-462f-8f1c-64992e28878a",
      "8ed4bcb6-b880-4706-8011-8ddac0ee4747",
      "012eef44-20cc-4f2f-9ca6-8099dc305592",
      "d88417d9-c637-489e-b774-f3e04882914b",
      "03ec6e41-8bad-4671-ba02-ab385debdf78",
      "37977fb4-f507-4143-95f0-82b7b09d79d0",
      "7c2ad15b-36f1-4c5e-b382-41178631ac7d",
      "92dcd5a5-240b-4bda-befb-a0343daf302b",
      "83e44eaa-e402-4160-ad67-f9a3992c1d01",
      "32f0e14a-7465-4de9-be28-c02ca59d82d7",
      "d144e97b-7b8f-4325-95e6-ca5f9d58b238",
      "6f4cdc9f-ab24-4ec9-9a0e-c26bb837adad",
      "fc9af508-8090-4e1c-b754-633763a2c3e7",
      "5314d424-2600-4226-b552-0f5dbadcb88f",
      "8377334b-d0ba-4c35-a82d-1ca86f22cf14",
      "fc1eb8cc-0667-488e-b5d8-7715a541379a",
      "dbbb86f0-a807-497d-8834-80317e49bce6",
      "2e449180-cceb-4eea-95d6-533704c20120",
      "9d1718e1-c604-4f92-9070-90f2b45aeb6a",
      "f1180fda-5422-418a-9b4f-45397a40ed2e",
      "288cda0b-031e-428b-ba51-9c95ca10d56a",
      "e982034c-4b31-4e1f-ae1f-3d2481ddb200",
      "5022379d-4ff0-48bb-bfbd-8740415877e5",
      "c1d7494e-6811-4ce0-8b79-6bf52dddb5ef",
      "fb8a675a-32f0-407d-b7ea-8f916752f71b",
      "6e1c79b5-843c-4345-b29b-f63d7812c85f",
      "f578b751-684e-461e-a39e-543df16a4c09",
      "54b5d08b-5ec6-44fb-9d99-96a099c3fc80",
      "6a0cc324-48c3-4459-bc73-86a8ee4aaa05",
      "69f49311-74dc-4480-8515-f58cafb3c5a2",
      "cf11a30c-94c6-43e9-b773-c7157ebbe8fb",
      "3694e869-3cd2-4726-aedc-cfdec1dc87bc",
      "d165c8f5-199f-475c-8997-48580a92dfcb",
      "63235061-70ab-497b-a51f-5ed0bdbcb17f",
      "5f3e568a-37e6-4c8f-af6d-91cfad8a5d73",
      "933be2ff-e4cf-4f99-ac42-781d77c4aae0",
      "cf22bd60-ff76-4e6c-9e5a-1f7c99a099b1",
      "17ea7b13-5a6d-47ef-a7ed-a43b4c600c0e",
      "af0225aa-ec65-4235-96a1-1c6e6b3e5912",
      "8b09f65d-af64-4aeb-ab29-1ee10ee7ab88",
      "52ed40ee-e22a-41f9-b948-230ac1dc373a",
      "343c905c-e125-47be-ac07-4ca3f01c643b",
      "51cd779d-7f09-45b4-891d-442b4a18d0e6",
      "7330f457-435f-46e8-a137-8af1ce6702aa",
      "c31adb71-695c-4d2b-af55-8664893c5be9",
      "912535b4-18aa-4161-9689-103f878588a0",
      "6425f4d1-e92f-4aaf-9d7f-0f6e0fd93239",
      "52aa2f9f-0c79-496d-9421-6f1d0174d28b",
      "a60f8720-a0b2-4ee5-91a7-280e2a0c4c8f",
      "e8140efd-860b-420e-bf46-53b7fbbd722e",
      "d600f3d5-bb70-4095-889f-c1a01165d929",
      "f099113c-4e1d-4c42-b43d-641cf7504066",
      "897987fb-a02e-40be-af94-33db8bdb3229",
      "3074c45a-9037-4a3b-ae0e-7a31a9b40c47",
      "b42acef2-f381-410a-b7f7-0f05190f3eee",
      "808d1a77-cbdb-414c-8209-0e823a9f25d5",
      "8f6c9c6d-40e0-4742-a7e8-821aec419d52",
      "833f5102-5ebb-44c3-aa43-2cc8fb2ebe51",
      "a75016d6-a822-4d74-b094-94a46cdc75a5",
      "f63e770d-e347-4f05-b063-de2df43ac221",
      "f0fa8205-fdb9-4b7b-8af0-3614ed153e1a",
      "ae9ddab1-f131-4ed6-9312-ad2c9c03f699",
      "2c5a36f8-79a7-4291-beb5-2118185cd898",
      "aefdefd5-e520-4049-a27d-e56c8586752e",
      "4d827d3c-3c4c-4941-a777-d3936b2d991d",
      "a45944fd-3259-4239-b89a-84b89b91a1a0",
      "2b2ad8ea-c413-4b31-a0e0-63ce7e33ceac",
      "280462f6-6482-42df-9505-aee1b9496f6a",
      "bfbaeb12-e66b-4308-bd46-e598f7727c45",
      "4cd36e22-2bbe-4c8b-99de-c5f7de370444",
      "71f1454e-f795-4050-96ec-cf1e32baea9e",
      "ca653182-ab34-4c12-8053-55fd08474c24",
      "294984b5-81ef-46a6-bf57-509f12ea9ccb",
      "f407eec2-d93b-424a-a499-885a075f8292",
      "672a04b7-2e14-41a8-8289-ca202150578c",
      "fb2b219c-d9ff-45fb-905e-84d665b21be3",
      "1f6eab13-040d-44f0-8d4b-277d077181ab",
      "4d3f20b5-7ee9-4763-a3b9-0933053aa9df",
      "ddc8c57b-f637-4efd-a35d-4eca3e59fd12",
      "96818663-1494-4522-a70d-5560b0bbef79",
      "145722e8-2c0a-4ea7-8218-ea7aa768db02",
      "3aa8c2a4-d379-44e0-a694-0441b32d83aa",
      "2a148ddb-9419-4a2c-ad01-8818b49c0099",
      "6b2866a3-adea-48e4-9f25-8efced0c03e1",
      "05f96312-65c5-4733-8fe5-88b57a35b158",
      "2e2158e6-ab33-4644-b631-623705dcc09e",
      "a5631a0c-88af-45ae-be90-0025fa892bff",
      "f8225cc6-a56d-40b7-9e1a-aa2a939217b1",
      "55f3c1ff-9b00-4ab8-999b-86069c80a5fc",
      "210a8352-e90e-4660-b97c-461a54cd1a1b",
      "7fbd990b-0913-40bb-a79a-13618fe8d61a",
      "76b1f6e7-b0a8-45e3-b046-5a280de54ea9",
      "41ec7cd1-34ea-45a0-8026-78e9663445eb",
      "da5b5ceb-27b3-454f-be30-84cb819c739d",
      "9e72f106-4d4b-400f-8e88-fdf7e9694655",
      "9d667700-cfa0-4bf6-93eb-f8ab80065a06",
      "ffd20f05-3b82-48b4-8d36-56d12d083d45",
      "7acc7512-7ecd-4161-88ae-9c6bc84df6e7",
      "ea7186a4-d4cd-4b8a-ac56-0e1790fa5986",
      "48417420-202f-493f-b886-c269baecfc94",
      "6e14b1c5-ff96-412b-8841-8fe54b742603",
      "f6dbef29-0116-47e2-9dd9-302872a7f1bb",
      "871ecd71-75da-44a7-93e4-8699251867ee",
      "da11c451-761e-4782-952e-4418a99d8333",
      "b66ed9e6-aa4c-4fa1-92e8-5a3528ec4217",
      "9d8e4882-d6bf-45ee-a152-9890fc24d6e7",
      "763f67f3-a7d6-494b-b589-b4787578855b",
      "6bb188eb-75ef-448f-b77c-5e7cd33fe221",
      "26a82f8a-f9d1-4ceb-b519-8cddcbaf8d41",
      "99983e99-6ba3-4802-9b04-be4033098c09",
      "3a2186dd-ee61-44f2-92aa-a70dc430ec3c",
      "e5265298-d107-4581-bf47-a590c98f8acb",
      "85c2709a-6229-4847-9625-0b2d937e3118",
      "6575d670-ed4a-4259-9ec2-f8f649942929",
      "97376b2e-ee33-47d1-a901-1c04c8b97507",
      "00993267-fcb3-4363-9498-3cf71eba8919",
      "8c8b0587-56e2-471d-b1bd-087d975ccaea",
      "39fbd44e-9a3d-4804-9098-c66c09561897",
      "d021bf02-9e86-41ad-a40a-289f2354cf01",
      "454749e9-2e22-4f6a-9983-94414b17c2eb",
      "08ff208d-0d59-4000-a7cc-b0e116a08a7d",
      "66e8e896-120e-4668-961a-671b155b8e77",
      "4e1a2942-50ec-47c8-be89-7897f4c0dedd",
      "9910abe5-b035-4662-a12c-aa14f1125adb",
      "a0b4ab4d-1f0c-41d9-8285-d6430a2d88fa",
      "1e2f3d82-9bc5-400f-8fae-8ae1b6c436e0",
      "4aced251-7d38-4343-af2c-cd3e12f78850",
      "49eba3c8-f801-46d3-959e-2c60b82d2933",
      "a987890d-cea7-4679-a88a-bf0346cb83ea",
      "ca030a73-f518-4ee2-a05e-e3f2ccdc1d4d",
      "51d21c3d-96cf-45fd-92d7-8bb7efe4fbb7",
      "cff70406-e0c9-4d54-a32e-e0cfaa281fc9",
      "4be00c01-c66a-4376-837a-e3992fc706b3",
      "453b2d2c-5d12-4925-8969-6499643e2e77",
      "acab97d0-d70b-4541-b00c-d8f4c9732e23",
      "12b4d37a-446f-42d6-821c-1b1ba7e4c63d",
      "c159fc3a-f0cf-475b-ba8e-264efdea91ed",
      "d26ee4e0-bee4-44a5-bb1b-c0f9b7708f11",
      "07f4a084-e575-4dc5-b503-778523d949cd",
      "1b1c831a-7fa7-4b42-a1d4-ba703f08b0d3",
      "df818996-3748-4f45-b04c-8f2806c21870",
      "22823cd6-102d-4696-a2a7-deb46ceef438",
      "2b2d51f4-79b8-422f-a3c3-54f2330a8db2",
      "5fe248cd-2234-45e7-9bb9-466ca4b13aef",
      "4c94b197-73db-4465-b352-f615d854865d",
      "d2b96136-050a-4cbb-8cd4-f83518165b28",
      "b3f73bdb-530a-407a-92d0-d191d7862926",
      "a73f0810-6fad-46a0-8a69-897a3e5f6188",
      "0a060b81-8fe0-49cc-8e53-1ae366e3648d",
      "a167ae78-6dd3-47a2-a202-05097250c828",
      "abc533bf-7a7a-4c08-b737-0c03e0e2a06a",
      "0e81d220-b5ae-419a-9d43-4e96bd6ef7dd",
      "63164023-f37e-4d56-bdcf-761915e8f48e",
      "478c1436-541d-4ba5-bf0f-8e2e1f116656",
      "a829121b-049c-4140-b195-99f28a17aa69",
      "73bb6bc7-1283-4b9b-b9f0-b2bd42afbcdc",
      "218fba3b-7759-4ae9-a4c7-6268ba3e9cb9",
      "d09b9d10-1f15-4b09-9458-49aac91cf941",
      "8e699087-3f6f-4bac-b101-b3ebe703b344",
      "a1418ecb-e9fb-4afa-9fea-36a6fee7cebb",
      "e4665637-c7e0-4808-8dba-01a02336d7f6",
      "c36a37f8-ce93-4bee-a187-787def2eaa7e",
      "3f8676cc-45b2-42e0-8e5f-daed9ebb6c2d",
      "704339dd-5b9e-454c-a39b-2212cf53577e",
      "d2a95f29-5007-4cec-ab60-bbb9eb509c9a",
      "88ee69ba-40be-4e9a-aa05-8ace2ce99bed",
      "0cac05b8-80d9-4fc1-9107-f4325a101b27",
      "bad25ec4-a391-4d71-a9ec-782374b178b3",
      "2079d43f-5114-4d97-8740-738e93ac1625",
      "40678a73-0812-4ee3-bcdf-9d3425c4e9c9",
      "11ed8ce8-74f4-4842-acb0-1c6faf6cb6f0",
      "ea3a1217-4abd-41a0-a3d1-f29c6adc53e9",
      "afceee59-3880-4063-8a01-1f681422793e",
      "70b6d74c-8564-419f-b2a1-4562252fa253",
      "266672a1-ca59-417a-8f41-b74e91d5ecd8",
      "20019bf5-a605-4e72-9437-d6e15c782f87",
      "b78dc95b-2a5d-4b9b-aadc-c31cf1031c61",
      "a9976a37-c83f-41e7-ad3e-a9972579d6fc",
      "05b04039-a9f3-4275-bf5e-706d385c9a7c",
      "e97c2880-678f-4239-9f42-eff181650258",
      "3cef04c7-a4ab-4a2c-8b7f-4702e3e358e9",
      "616dd08b-8008-474d-bd08-430f1dd03c70",
      "3b62a461-837b-4560-b15e-f20d1d65c0ac",
      "6da677d6-8827-4daa-adb3-2d78b4174b67",
      "d29029a4-6224-489c-87ec-8b6d5f39bb79",
      "e3d1b202-1985-4b3b-a443-4385ccdd2a85",
      "3e8fe07f-ddd7-40a2-af7c-2a98d653ed7c",
      "df15b7aa-a626-47a9-9593-e852d1f970f6",
      "8de45106-f0ef-4db4-b4ac-d33d731b7353",
      "618cd019-7dde-453f-92d6-bc032d2d8e85",
      "5215a119-f3a9-416f-9c2f-4e8fa45f1db6",
      "5d31a9a1-362b-41a2-a6e3-e3b18f13a45c",
      "0a634974-2d3b-4bea-b3de-fa2e9165f3e5",
      "3d4d81e5-17ae-47bc-8935-c63c059cc714",
      "3478f212-8f85-41e7-96d2-7a968346c4c1",
      "0a62fc58-e331-4fd7-9ef9-777aa11199b4",
      "23287d80-62df-4865-933f-aa61e3f78053",
      "ec224809-7d73-493d-bea9-5514bb86ef88",
      "7ed2fc36-3fe5-476b-98ed-03173e9688fc",
      "57466138-7a3d-488d-8183-3dacb910f8e7",
      "60862098-0b2b-4eb7-afe5-e6639d459c4a",
      "3187a279-acb4-48a7-a317-6d84e7acae69",
      "bc410b4d-1b1f-4301-8f58-57cb07e89599",
      "9d8faa7a-5096-4308-b53a-db5fb6289bfc",
      "85917d04-65e6-430b-b3b6-19786f649d0e",
      "a2aceaea-fb27-4434-87c4-0c60b32d8ef3",
      "d591d927-a4b6-4736-a2c5-a3a570b189e9",
      "56773b66-0e5d-4619-8274-856071848016",
      "a9e0f0d5-76f9-4074-83ab-5e4ea1797539",
      "1f1cfc7c-6511-467d-8bb8-8e7a5e051d27",
      "61c91ee5-f3e3-4a69-81ab-c7183d080d08",
      "7b1d02a3-0626-40ea-83ef-f143975a6ef6",
      "0a431650-c5ab-40e1-9db9-d31cbb80de2c",
      "94a69a40-4009-42ff-a9eb-8d658bb0e14b",
      "b3dbdeec-75d7-472a-b216-67e277fb51ae",
      "43359ec3-5f69-40ab-824d-e72a5317dd19",
      "c905f421-deed-4878-af70-f6cad3cb85f5",
      "eddc6149-3718-4b64-bba0-1e5755ba2037",
      "e94ba8c6-745e-41fb-a95d-25743a6c5c54",
      "4b42ad69-1bd6-48b3-80c9-917e3e59e756",
      "11102926-2aec-4d7d-af10-6821b3f34d19",
      "10c75d87-751a-4be9-835a-6af3572c98a4",
      "36bbfe7a-75e9-4935-b0e4-98131bf08ab0",
      "5a00a97a-1a8b-4c62-91a9-b326ecb9456d",
      "98f124e3-d70a-43fe-ae25-3f29faecdc7b",
      "710958c6-a95c-44b5-bcf5-d623b1d63ee7",
      "e153ec6d-a281-43e3-8968-72dd44464d46",
      "98f068e0-c4b1-47b6-9b63-fceb18ee4a89",
      "eb04ba4d-4456-460b-943a-1347978ca189",
      "24e0cf62-b7fe-4d1b-be12-b911e14125a8",
      "20abe9a7-c0ca-403b-9ede-b69b9e30b93f",
      "9a297c37-05c8-46bf-bbe5-72836b5040b4",
      "b43cc3a9-2b30-475a-9977-c2ade7b4c04a",
      "bd479daf-e54b-4aff-b75f-cd39788291aa",
      "f98608a9-a108-4ef2-b2c5-90155be38da4",
      "6e9c12f2-9b2d-49ec-877f-9ad6718f0a71",
      "54886f08-d709-4b45-8696-59366fd40ba2",
      "d03ad46d-4b1a-4d39-8f1a-514c70b7d88b",
      "b3638eb3-2b00-41ca-be92-c2be8ad4ac94",
      "fcaca2d9-32a7-495a-8b41-d3077f8036b7",
      "5679868a-7d40-44f4-81e2-40cd397bfcb5",
      "34607342-dd0f-4d73-9aee-0afca97f9d85",
      "fb265b00-69e3-4326-86f0-91f4be62ebc6",
      "0b0ff087-e861-4849-a7b6-03217c507759",
      "8670a517-ee22-4743-bcc0-573ee80ff39a",
      "84bbc661-9acd-47cb-ba24-c32306a8e332",
      "14dda7ba-450b-4a93-af81-de6b039b15e5",
      "3bfcb011-966c-4803-94b5-f2bdf28347c0",
      "662aad5e-5247-4cec-9387-b66ff1e63e8a",
      "4b0b7f6f-ef7f-4aa2-8471-d8a82c72c3c8",
      "b408c3db-6abf-46a8-a902-b869158eb65f",
      "f520e69f-a24d-45c9-bce7-1614d0c9333e",
      "be742479-28b2-45fb-ac15-5c94a497fe20",
      "a5ec048a-5f3c-4f26-b66e-4011d416f6fc",
      "99e2c9cb-b3bc-4aa3-affe-f9f08c2ac0b5",
      "d8f32fb2-b505-462d-bce1-ed789bf76a1c",
      "dbcf08d9-3d0c-4175-9fe0-e0cb2fd036bf",
      "d03315e8-0272-43e2-bab3-26a30418ead2",
      "d0537aaa-5637-481d-9b2f-e312605fc5c3",
      "7e69bdc3-0bb6-4f3c-a374-b7d1494b218d",
      "a2e3a489-d210-486b-a91d-6633b18d6e0a",
      "076d36d0-7c59-4d2f-908f-5a7526bcf53e",
      "f2addbd7-6525-4af6-91b2-4efdcef3534f",
      "9ad2e9e1-42d2-43c2-bd07-8373f49cb54a",
      "edd8a46d-2967-4860-960b-6896864cef29",
      "01b01ff8-0b91-4bdb-8a1a-404be646e11a",
      "3aec18de-3bee-49e9-980d-07877e696aff",
      "d406ef5c-57ed-4926-89cf-e3d3d9432e67",
      "76caa7cb-2f6d-40a8-869b-27b5506f02a2",
      "4042604b-8d71-4b89-9390-517bf96aaee5",
      "8c3eb6d4-68e9-4b77-80bc-d7ed8063058f",
      "8db42895-164b-4b5d-95aa-53bca51e1e8c",
      "738e4a98-9864-44d0-95e1-78dc040ea1ea",
      "6efc08ac-aacc-4df2-bb57-d069703cec64",
      "a7bf2456-4163-46d7-a526-db2def774b8e",
      "44001b7d-3899-4d91-a9ef-ebac5ec24b1f",
      "ae871f0e-7fac-4e31-8695-a5cd1f653ff0",
      "d75175e7-78f7-4a31-ba6e-9000c5258289",
      "901042b0-a29a-4326-910b-ff66a81769d3",
      "ac82186b-5e24-4191-a405-aed33f14828a",
      "1095b02d-da18-437f-ae46-99a36badb2d4",
      "7bd9b045-806b-4038-b455-fc4311fb0203",
      "4027bd09-b50a-427d-80c0-69c8c28eb01e",
      "d972f8e8-9ca4-4f2c-8ae8-946b0799748c",
      "3e551fcb-0276-462f-a85f-ce421a6cd01b",
      "984c0a01-3562-4be3-bcdb-1e64116f5861",
      "fdbca074-0056-4165-b5d3-9abb3fb61733",
      "b0edf924-6729-4be0-a73a-832998772dd3",
      "a6072d06-e09c-4a18-9902-018c4fc57a4f",
      "7c1c73b3-8f7e-4dc4-ab7b-e52eda4182c5",
      "7181202c-2ebf-4996-bae2-433921ccc4cc"
    ]
  end
end