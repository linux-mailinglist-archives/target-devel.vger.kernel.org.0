Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D135D2E8383
	for <lists+target-devel@lfdr.de>; Fri,  1 Jan 2021 11:58:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbhAAK6M (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Fri, 1 Jan 2021 05:58:12 -0500
Received: from sonic312-23.consmr.mail.ne1.yahoo.com ([66.163.191.204]:39573
        "EHLO sonic312-23.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726555AbhAAK6L (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Fri, 1 Jan 2021 05:58:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1609498649; bh=ZGFWoJfVxhB4JLkgslg448+IHooA7k3446w1GHhQqrY=; h=Date:From:Reply-To:Subject:References:From:Subject; b=P7tvrzb8NcH6qHyVMI5aC2Qu6+/79LBi+PRmph6m2PzIgRZ7bbT1VXcvVwzZXI1qAX60405s9rie516MoXt1huD1sX8Bu+v52j8fbYEldVKAHyL7oCLAC/6WLqGiEME6P3RiLfj6+3vEDLYUKe6hjni+X2pHXRNSobkmR8zaiVDCcQkE0BynFXYWm7CZbLmvvjrHpHVlXriaCyju6OMRbN6AUZSWtJBWN+1tAFL2xLY91votca/479KGQPdn4XITz1xZJeLsPdcdP0ji6jJ2Nokl/LZ58IN+akVKXvloEFt+LbTGYrDubwT5aq1YYQKQ7Q0TUIQW0v6B4BERS9VPjg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1609498649; bh=v9m99v5Zt8WA8Rzi2PtInJwqEOG4o4JwJzCUhghWxR5=; h=Date:From:Subject:From:Subject; b=T3ycriLMGjz09lmyVAxRUH7Nx3eXDEyGQsDGhPTRR9sCdlBANarCGgBTml+jEEc76McJfP2cTSn6AMGql0r96XtmjHEOrp184xQOi00ea54lVXSzcBRTCnfFRo798IAvE71yobuUYexe/dtLoVyMGu3UqI2n8WVfmNwm8tseWJPbKAr7lWz0Z7/eoZGtGphdSWfZWaNQIwGiDGNXGfkiEOnluMGA799I3aTDIB6cpfU5aejLDsqcq67FdAa8ntn3EFOyi6M4gpB7GxCm506hKZe8SH8fQ+qJshWXA2uHUgGgBujFgRxbsm/8FU17btp00Zp1zWJ2xmkEzeVqlZdSAA==
X-YMail-OSG: J4FDfEwVM1nZJd700K6nznfCaxEDD_.VF519DyP1GyONPLRpca3dH2jtOYM2ZKN
 IpaGGDuCkugU2iI5UuAq2VmE8xG3gpt9dfeFoYX4jH9zuiN11QhocWf7y4KJU_ql0d6qmt_hGbEp
 JZM.p0AROHL2B0CstgIhHYPw7EymD_04GOcECwfCcbCHXWXTWSOeNI55zc.Dhge1ExHI4nxpiLwd
 F.mvyUDn2qZcxkzo9cw4kSdBfNcT6kohBQjNXrJvllS_HxJrjG7OC5PYeIYBifGm4SXiLnWh6k4a
 kaX04Wy0pDCigJTqr7UyTUca5OF.bTMf4KfGcEoFsU5yurxBHqPUVcTcopuNcqLmUU9cAxI9lDQX
 uGkwibrhUyg7cRXVX8rqRrRznvyjzu5c1PQOXhC0nkYiak1o035xz1PEHSNbBKbKv793uorVLRn4
 O8k._sPGSQ7nSNn3JUl34EGLgHVXLfus9SIhFeDXkcrbh2gJOq38q7GxtCnPTw5pUNXSx71_8QLb
 sWovpw78IcIwhZ5nkeOD9tafYsbSbniWXIAU5kUc7KWjSB4UTrSV_WIbj.Z4mhgAr89LLQhX0_PZ
 5FGdH373YWvQjDUVWwBSCclPKkdZdlOTG4IfyvL9hrcFTvcrBYCuIBrddfuuFlXrGzT9fEBaZPgb
 8._CVqJaGb54FdwZBY3SSzfOnbzjYaCMyD081uQu.lCKnQztLYl24rBmzJCYX11TNIzPsrvwplAB
 gnhGpdpqix0gMVzT9LhJjNqVA_WqgwTOEsJWr9dU70FitUNztojEHOOw6VpphxQAUGQ70_KUGFHL
 bBkUVVQiE7eKrHSLXpIc0duRRvVQY14v8CP6l5B9Y4dHBbcpBPvTiR1WfKvedwRCq_KO41mycFvJ
 7bY66HulxdDIXM72NJqaQ7g1.1n1rJRA045dp.lhnUFgnwq43yCFAtwP7FDLTo6xfUXNUD5uUeNV
 Kq5jJtdB5BUYVR7fVrYWmQ828eQsO8PS4hsFZavwXqss3NWmw8x3WfuXY1E17bcRYVp._POioT1Z
 KYASKa1kUNfbpLohxCYp9wXqfylyf2gXAvbBSL5Cib7vqa.f5Q3qbl60I3bxPtcOacLSB5t1PgmA
 z853WE7Swtr_6OsCfiA5xPT374cEph3ef3WCYgaJ1wxWMnm.8Wd2h__.HO6kYbBx83AeK_f811tX
 RJdJ0kW1mdYFy.s3byCoR_KjgHuqfxhQL_3_1ubwv7.6M1vDrvN9tn7_Q6TIWMsMVcNAFpfJTW0P
 NoB8coP0kzlYJhc1z5a93X.Z6UIiUEaXt2HNRtVb9mTa4XFK1HT9EPt5ODN9coKUBlcd6UEn4ylj
 TCt7at_bgpNGgtKPHTheQTPuTFyXpteVH.JCoGG_OC7GcUjx49wBFe9aCOfR8bubxR0NSylc_ipj
 xkOWESr9JWRm7oxIA3dmnX.OOOfUg6g3xczce.0xPA2lTEW3oHGzxHWTk_sPJ86AmNEHIMO9MLbZ
 ibBgtbCqfFFU2dc1GhqdunENhcKAd_4zpEeCx_CkhcmXm5lGcIUKqfBJd5Bw5ABeO129esOjMWCt
 K4q7POeAqEF5AWMcEVnGOQ9r64m8IE4vqPxY.sP12qPFBthETqLjVAsdSY580xGjE8DN3v3NQ6AG
 vdS8qmt.Fo4FwrqKvSW6dcRO2HGqNXpWi4RaS9KGChDkbrbtFQKa17zlpatk6fgjYg4vfHeqGcfi
 xy3brqCVteRc1u9lfNTjjMOAxI8jMHrH771hPS50ZdCcjDpNX8b.qw65zTapYq6eKb_LBazlDHV2
 iHvWCNYaZHxGvjkYt3foTHHd2LQOiolN13waNlpWKjnP1tOBsK5r2r6nhE6W_FVNhkS4Pc3TQ51R
 xdtdXRE1I6ZSURiaGP53NUhDX7DIcah6ryBoKy.i0Ey5tRdNoDmVn3UOF.LPcsJI_lxdFtnlFCVk
 l2LenjfY.cdmOV_7QL_jeWEi.8eapaYeHdOHp.fJNy9rd0Z65Ath4u2.b1HXBprwXSHMMeseV1vE
 ukWUMhLGdVXr23uAQAk2hLNBmDKsF6.BuMkxMy2PqpKibWwiIigw4tzmbPj4vAxQsM5m_KcrigKC
 d.fWHb__AWnBsRro_NHtGV1VcboTBQSha0PpC91lpVNwarA3sNflPX2ZWy0KynujyjQ7hT0_rXfH
 Gggt4_whaQeNmUyPy0pr5PX6MuCJgSRIm1OvAjXNgzWEArWTE_O1k3WQ_uPAOghZgYp1gmXahVs8
 pDaSKlei9__LN.dHDX7UMhL8nlSjIsYttd3wiJqIyStFa2J6gJACmoYukyYQ.SdDBLA77WqKgEJc
 YoJtJxuM6wdydHKGeOnBh4qKDCimPmnNAWaaEIzRuPdgKS_.68Ik_Ael3TzZ0F5HU18m7t9DcmOI
 xq7Z6J1RcjHFcbrXP6cmVSdKNTI6Hv28L1m1uYeyXc5m1Tu8YCbh1UnDaj3h_c4YLIdAFBtenRZQ
 ueFUGvm0kuCEdCMDAO0pKcO4oeinxSkWD9DqpkeNKnzSzhqLlFdpXqdutUsvOxmV5TQ4VFiAIgZX
 g2qLWRxkw8BDu61LfA_LlJR6fMks1ejqYcvXPY1LfGr4wUd6fgAjWlGC3bm.HSVcXf4Jbg25kNF0
 bpxrkOOrF4X5C4RQmH6imZYxF73uH5PtTRrNVglPSPlO.y_Cuc2pVbaHPM.FMVyAg5J_oTJHlT2t
 _Uy4cjcJeGy7tlw6cLCUL.Dr5U9G7v6SJ12oDTpyhyEqVQQOEEWecfWmm_rVp73xxXgdrW._mZ0.
 8nLB2u3HiR6evRQVsBh7_ElcIOTfBGRqCAcgVr0FTBdwAphOYyAazYvwv.a7CDY_qQyveYzIGBxw
 RHpVWQDMPbyOJCo89ympJbRrmQPPtXjY4_gIpDCUS5BN6tF1jJADB071hHSKur_2ytYinUZtu45N
 5TLB895Lha42A1mZwVufhnyiIXK7RcKWD1DirPZ0hD77FqDaBjQgI4acXw.H_nSErAIEiYufJGFJ
 d4m_82L3ewwyGOD8FjKhUWVmeUutXRmcpzINz4K1LlGI4uDSNoP0c77ShEMKIxpD_maTG6P0eOaZ
 RS0RLQ9dPv_DDOo2tq99gDY6hnM6q3UC5GXXybSGpZB6cJHylauUYxOsYeSsIZ2Cr0WHz.CN6TO3
 YMu1oZufvQqnh9RZyLY9AexcpMkxEdw9Xn0WV8.0q0bhMUgnh592YIZ8PiB3hPUHBQGRksvEtrcQ
 tDLdO2luBDoxkXU91EBlHmqcSZDP2wmuMnTEyeJTdSI7YcVkNWRPSvI_Z7ziYxDC3nNEmanEmync
 TMG42XILHp4FPtAroHx6VyJUnKoKk6iAPbA605WEQUpuYD5xrDX4j_pXiYxNhR5xW2VNy9dnKjjd
 Es7NotdoCDVEeq9gfu44r.8.KBBK9_ViuzoPapKlOt7nNc_1jPYRwXNlfKarHzvZ875u4tPg6MFn
 iwy6F1PnlNNPCzXTWKrKDE2wssjVJEHmKSErYYxYNV1OG.skcItO0YbPzZb5LXHG6xPPbrdbIM6K
 _9p6yM248_l0toWjjDtqq2t6z5Sb38ZK.qWXF31osGuJ4fHgjfniE.Pek2U0DG9MQn7moBccuTGn
 c6EsvgD3iLIplJ7mDXGsnX47c.FqmzmhEA3QXoa_rBH9V4qde9CgqOUKeuRMfC8dFp0BjA9b2gZL
 f6ulRzcD00Mf9IgT_1G0Dd6Ka7V7GEWqxSZSM6a7FQwupfoat5tZaeg1a6y_yMXvxYJmAvVNs5aX
 GWowp.PUqw.08AT5k80HJqywgYgbLxHNaF5ewggIBt4LiCyjWenX2UyGoB5dL9EnXhGPtWKrDZjP
 Z3ZkY747j_oCrSj9NgGwe3cNaopZSJ3i2HPPV01T3mF_MjrgLB8GgNQGxfMaSeKIc0AqgMlfbQgo
 XxPtUGM3Y28NMBNWBvTZL8_E.fOKLmIcuH5rJT7h1KZf06AuFIKp.Cw5vdRS8Wl.ba1T4XsXJox6
 ZtMhyxg66KAI03OzQgyAw9JIC_Lz4Ufw_n7nR_LUbN8T38wXOfGT8bz3M00iSh0hbJPzCoJIWcbJ
 MViqQmti0AmZiqFxUZFtg7zHxbs3KkXj7UFvKjVh_pYWMymL9HH_OUCEZliT7RCmaK7jhWylSp.2
 4hjOmUxWCs06pKe42Rf.3r2BkiGrnrdZK.NYcr6uuJNxGCnsbnRCyXQ5bX.la2IX.Wo9J3X3kBWS
 RxE21jlb8T9ASgiFcXY6BJ4.7ETNdcU7yWv2a10F_T8cR5jXJIU18.8Msap5KTZacUvqmerT.bNt
 COo1LT2fGW2O5LuMqdSDT0wpAe2JxvbPSjop.0CXkTBJ50o79t9CDWyMcuIU3Sj5GkrI2kxzDTjN
 RuG8.3Jzl9uKVBEqY8fuX9o92FwRmw2ryz5XdvX3fiM17JuNtRovlrjjHBvFx35al8A0JNdqWmLS
 0aPoq8qWDJz7UMeUxGGg1O4c7kMue.BmGKBRXI_m9br3_ga.kihADrfI8s7tdAnSjGL2j2kilc.s
 m7Tgh90vohuimDNMQpqg6BKregbZ48j7d7iDpg.XP8u0g5YgRm7Lj_npQ_IPX.CvSARlwMA0Ot5P
 H_gS0ejH_xm153gUmg1NkeNSN3qSJparYMUDCQ0kUG4YD4o7QWqSQ3Pb2BAxd0aBmjxSLbH1b0QE
 xGyliwauL_F_x8iopJ4Nvv9.yMx5n01RvOweyj_SCAvBUY.xkkx1gtYjPUmadSjcz6kmeMpgH39D
 6Fng9samLNuTLVoi3lXls_eNr8MMlIgVQmmRSQp9n5_.UaC4yVzxUawv_wTUo3cmQ2O1d9PMIH3S
 xK6x3Vi2l0aW1m3FpSVPM8PH4Vs_L8DhURuDZ_1YkIbC9xDdfBtP44oa_Fq7oxHeng9C3hL4yYzV
 GTXjd8Eqkw.QqnOB5LGCVcrzkx3zocOMDFGvQ7b6_NemwUWIkiz72gyotmfPgcFALBjA8zJcFnWI
 UWKPn5L67B8a.WUO_I9PcAAyaZDGVbi0JyLvYQf0H95_JYbMjnaBq4VgWkQzMkEjeOc.emAbs3tH
 XoszcckS6z6gPh7Z_TurA4FuTwBx2ZejPnCyMjORVIwFVywdbgfaJDvcDphFe2oYCoUQ15.1afhw
 wjEUeQ.vcoMPHKXHBonaYLZUNCu4sANobc11_ufIGYvA4EaoKHI0y0XhV4k._drYRIhnxXO5x.d_
 XpxLSNqotxelI47i95R5Grh8Oz21Ok.LcQHHJKkyeFCK6KB2UE7n4PL9afu382Btn9rDwvxckTsp
 2r6_UlLcBnvuSOrwiV7vTZqeOyMmpWkJ0GCmYIjSbFbO6JiYifLqihefSg0vxGvZnfw39GxGI
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ne1.yahoo.com with HTTP; Fri, 1 Jan 2021 10:57:29 +0000
Date:   Fri, 1 Jan 2021 10:57:24 +0000 (UTC)
From:   "Mrs. Mary Jackson" <marylucasjackson@gmail.com>
Reply-To: marylucasjackson@gmail.com
Message-ID: <94829127.6187648.1609498645000@mail.yahoo.com>
Subject: Greetings
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <94829127.6187648.1609498645000.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.17278 YMailNodin Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.88 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

My=C2=A0Dear

=C2=A0My=C2=A0Name=C2=A0is=C2=A0Mrs.Mary=C2=A0from=C2=A0Norway.=C2=A0I=C2=
=A0know=C2=A0that=C2=A0this=C2=A0message=C2=A0will=C2=A0=C2=A0be=C2=A0a=C2=
=A0surprise=C2=A0to=C2=A0you.=C2=A0Firstly,=C2=A0I=C2=A0am=C2=A0married=C2=
=A0to=C2=A0Mr.=C2=A0Lucas=C2=A0Jackson,=C2=A0A=C2=A0gold=C2=A0merchant=C2=
=A0who=C2=A0owns=C2=A0a=C2=A0small=C2=A0gold=C2=A0Mine=C2=A0in=C2=A0Burkina=
=C2=A0Faso;=C2=A0He=C2=A0died=C2=A0of=C2=A0Cardiovascular=C2=A0Disease=C2=
=A0in=C2=A0mid-March=C2=A02016.=C2=A0During=C2=A0his=C2=A0life=C2=A0time=C2=
=A0he=C2=A0deposited=C2=A0the=C2=A0sum=C2=A0of=C2=A0(Nine=C2=A0Million=C2=
=A0Dollars)=C2=A0with=C2=A0my=C2=A0name=C2=A0as=C2=A0the=C2=A0legal=C2=A0ri=
ghtful=C2=A0appointed=C2=A0beneficiary=C2=A0to=C2=A0the=C2=A0fund=C2=A0in=
=C2=A0a=C2=A0bank=C2=A0in=C2=A0Ouagadougou=C2=A0the=C2=A0capital=C2=A0city=
=C2=A0of=C2=A0Burkina=C2=A0Faso=C2=A0in=C2=A0West=C2=A0Africa.The=C2=A0depo=
sited=C2=A0money=C2=A0was=C2=A0from=C2=A0the=C2=A0sale=C2=A0of=C2=A0the=C2=
=A0shares,=C2=A0death=C2=A0benefits=C2=A0payment=C2=A0and=C2=A0entitlements=
=C2=A0of=C2=A0my=C2=A0deceased=C2=A0husband=C2=A0by=C2=A0his=C2=A0company.

=C2=A0=C2=A0I=C2=A0am=C2=A0sending=C2=A0this=C2=A0message=C2=A0to=C2=A0you=
=C2=A0praying=C2=A0that=C2=A0it=C2=A0will=C2=A0reach=C2=A0you=C2=A0in=C2=A0=
good=C2=A0health,=C2=A0since=C2=A0I=C2=A0am=C2=A0not=C2=A0in=C2=A0good=C2=
=A0health=C2=A0in=C2=A0which=C2=A0I=C2=A0sleep=C2=A0every=C2=A0night=C2=A0w=
ithout=C2=A0knowing=C2=A0if=C2=A0I=C2=A0may=C2=A0be=C2=A0alive=C2=A0to=C2=
=A0see=C2=A0the=C2=A0next=C2=A0day.=C2=A0I=C2=A0am=C2=A0suffering=C2=A0from=
=C2=A0long=C2=A0time=C2=A0cancer=C2=A0and=C2=A0presently=C2=A0I=C2=A0am=C2=
=A0partially=C2=A0suffering=C2=A0from=C2=A0a=C2=A0stroke=C2=A0illness=C2=A0=
which=C2=A0has=C2=A0become=C2=A0almost=C2=A0impossible=C2=A0for=C2=A0me=C2=
=A0to=C2=A0move=C2=A0around.=C2=A0I=C2=A0was=C2=A0married=C2=A0to=C2=A0my=
=C2=A0late=C2=A0husband=C2=A0for=C2=A0over=C2=A019=C2=A0years=C2=A0before=
=C2=A0he=C2=A0died=C2=A0and=C2=A0unfortunately=C2=A0that=C2=A0we=C2=A0don't=
=C2=A0have=C2=A0a=C2=A0child,=C2=A0my=C2=A0doctor=C2=A0confided=C2=A0in=C2=
=A0me=C2=A0that=C2=A0i=C2=A0have=C2=A0less=C2=A0chance=C2=A0to=C2=A0live.=
=C2=A0Having=C2=A0known=C2=A0my=C2=A0health=C2=A0condition,=C2=A0I=C2=A0dec=
ided=C2=A0to=C2=A0contact=C2=A0you=C2=A0to=C2=A0claim=C2=A0the=C2=A0fund=C2=
=A0since=C2=A0I=C2=A0don't=C2=A0have=C2=A0any=C2=A0relation=C2=A0I=C2=A0gre=
w=C2=A0up=C2=A0from=C2=A0the=C2=A0orphanage=C2=A0home,=C2=A0I=C2=A0have=C2=
=A0decided=C2=A0to=C2=A0donate=C2=A0what=C2=A0I=C2=A0have=C2=A0to=C2=A0you=
=C2=A0for=C2=A0the=C2=A0support=C2=A0of=C2=A0helping=C2=A0Motherless=C2=A0b=
abies/Less=C2=A0privileged/Widows'=C2=A0because=C2=A0I=C2=A0am=C2=A0dying=
=C2=A0and=C2=A0diagnosed=C2=A0of=C2=A0cancer=C2=A0for=C2=A0about=C2=A02=C2=
=A0years=C2=A0ago.=C2=A0I=C2=A0have=C2=A0been=C2=A0touched=C2=A0by=C2=A0God=
=C2=A0Almighty=C2=A0to=C2=A0donate=C2=A0from=C2=A0what=C2=A0I=C2=A0have=C2=
=A0inherited=C2=A0from=C2=A0my=C2=A0late=C2=A0husband=C2=A0to=C2=A0you=C2=
=A0for=C2=A0good=C2=A0work=C2=A0of=C2=A0God=C2=A0Almighty.=C2=A0I=C2=A0have=
=C2=A0asked=C2=A0Almighty=C2=A0God=C2=A0to=C2=A0forgive=C2=A0me=C2=A0and=C2=
=A0believe=C2=A0he=C2=A0has,=C2=A0because=C2=A0He=C2=A0is=C2=A0a=C2=A0Merci=
ful=C2=A0God=C2=A0I=C2=A0will=C2=A0be=C2=A0going=C2=A0in=C2=A0for=C2=A0an=
=C2=A0operation=C2=A0surgery=C2=A0soon

This=C2=A0is=C2=A0the=C2=A0reason=C2=A0i=C2=A0need=C2=A0your=C2=A0services=
=C2=A0to=C2=A0stand=C2=A0as=C2=A0my=C2=A0next=C2=A0of=C2=A0kin=C2=A0or=C2=
=A0an=C2=A0executor=C2=A0to=C2=A0claim=C2=A0the=C2=A0funds=C2=A0for=C2=A0ch=
arity=C2=A0purposes.=C2=A0If=C2=A0this=C2=A0money=C2=A0remains=C2=A0unclaim=
ed=C2=A0after=C2=A0my=C2=A0death,=C2=A0the=C2=A0bank=C2=A0executives=C2=A0o=
r=C2=A0the=C2=A0government=C2=A0will=C2=A0take=C2=A0the=C2=A0money=C2=A0as=
=C2=A0unclaimed=C2=A0fund=C2=A0and=C2=A0maybe=C2=A0use=C2=A0it=C2=A0for=C2=
=A0selfish=C2=A0and=C2=A0worthless=C2=A0ventures,=C2=A0I=C2=A0need=C2=A0a=
=C2=A0very=C2=A0honest=C2=A0person=C2=A0who=C2=A0can=C2=A0claim=C2=A0this=
=C2=A0money=C2=A0and=C2=A0use=C2=A0it=C2=A0for=C2=A0Charity=C2=A0works,=C2=
=A0for=C2=A0orphanages,=C2=A0widows=C2=A0and=C2=A0also=C2=A0build=C2=A0scho=
ols=C2=A0for=C2=A0less=C2=A0privilege=C2=A0that=C2=A0will=C2=A0be=C2=A0name=
d=C2=A0after=C2=A0my=C2=A0late=C2=A0husband=C2=A0and=C2=A0my=C2=A0name;=C2=
=A0I=C2=A0need=C2=A0your=C2=A0urgent=C2=A0answer=C2=A0to=C2=A0know=C2=A0if=
=C2=A0you=C2=A0will=C2=A0be=C2=A0able=C2=A0to=C2=A0execute=C2=A0this=C2=A0p=
roject,=C2=A0and=C2=A0I=C2=A0will=C2=A0give=C2=A0you=C2=A0more=C2=A0informa=
tion=C2=A0on=C2=A0how=C2=A0the=C2=A0fund=C2=A0will=C2=A0be=C2=A0transferred=
=C2=A0to=C2=A0your=C2=A0bank=C2=A0account.

Thanks
Mrs.Mary
